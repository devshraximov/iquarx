import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:iquarix/iquarx_app.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asosiy Menyular")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScannerPage()),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Skanerlashni Boshlash"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  HeadlessInAppWebView? _headlessWebView;

  bool _isProcessing = false;
  String _statusMessage = "QR kodni ramkaga to'g'irlang...";
  Color _statusColor = Colors.black87;
  String? _currentUserAgent;

  @override
  void initState() {
    super.initState();
    _initUserAgent();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _headlessWebView?.dispose();
    super.dispose();
  }

  Future<void> _initUserAgent() async {
    _currentUserAgent = await getDeviceUserAgent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Skaner")),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: (capture) {
              if (_isProcessing)
                return; // Jarayon ketayotgan bo'lsa, to'xtatib turamiz

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String? codeUrl = barcode.rawValue;
                if (codeUrl != null && codeUrl.startsWith("http")) {
                  _startHybridProcess(codeUrl);
                  break;
                }
              }
            },
          ),

          // 2. MARKAZIY RAMKA (UI uchun)
          Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isProcessing ? Colors.orange : Colors.green,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // 3. HOLAT HAQIDA XABAR (STATUS BAR)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _statusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _statusMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  if (_isProcessing) ...[
                    const SizedBox(height: 10),
                    const LinearProgressIndicator(color: Colors.white),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ASOSIY GIBRID LOGIKA (HTTP + WEBVIEW)
  // ==========================================
  Future<void> _startHybridProcess(String url) async {
    setState(() {
      _isProcessing = true;
      _statusMessage = "URL topildi! 1-urinish: HTTP orqali...";
      _statusColor = Colors.blueAccent;
    });

    try {
      // 1-BOSQICH: HTTP REQUEST (TEZKOR)
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': _currentUserAgent ?? "Mozilla/5.0"},
      );

      // Agar HTML to'liq kelgan bo'lsa (Masalan 1000 belgidan ko'p)
      if (response.statusCode == 200 && response.body.length > 1000) {
        _finishProcess(response.body, "HTTP");
      } else {
        // 2-BOSQICH: AGAR HTTP O'XSHAMASA -> WEBVIEW (PLAN B)
        if (mounted) {
          setState(() {
            _statusMessage =
                "Sayt himoyalangan ekan. 2-urinish: Brauzer orqali ochilmoqda...";
            _statusColor = Colors.orange;
          });
        }
        _fetchViaHeadlessWebView(url);
      }
    } catch (e) {
      // Xato bersa ham WebViewni sinab ko'ramiz
      _fetchViaHeadlessWebView(url);
    }
  }

  void _fetchViaHeadlessWebView(String url) {
    // Eski WebView bo'lsa tozalaymiz
    _headlessWebView?.dispose();

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(url),
        headers: {'User-Agent': _currentUserAgent ?? "Mozilla/5.0"},
      ),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true, // JS ishlashi shart (SPA uchun)
      ),
      onLoadStop: (controller, url) async {
        // Sayt yuklanib bo'ldi, HTMLni olamiz
        var html = await controller.evaluateJavascript(
          source: "document.documentElement.outerHTML",
        );

        if (html != null && html.toString().length > 500) {
          _finishProcess(html.toString(), "Headless WebView");
        } else {
          _showError("Ma'lumot olib bo'lmadi. Sayt bo'sh.");
        }
      },
      onLoadError: (controller, url, code, message) {
        _showError("WebView xatosi: $message");
      },
    );

    // Orqa fonda ishga tushiramiz
    _headlessWebView?.run();
  }

  void _finishProcess(String html, String source) {
    if (!mounted) return;

    setState(() {
      _isProcessing = false;
      _statusMessage =
          "Muvaffaqiyat! ($source)\nHTML hajmi: ${html.length} belgi.";
      _statusColor = Colors.green[700]!;
    });

    // TODO: Shu joyda Backendga yuborish funksiyasini chaqirasiz
    // sendToBackend(html);

    print("🔥 HTML OLINDI ($source): ${html.substring(0, 100)}...");

    // Natijani ko'rsatish uchun kichik dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Natija ($source)"),
        content: Text("HTML muvaffaqiyatli olindi! Hajmi: ${html.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Dialogni yopish
              Navigator.pop(
                context,
              ); // Scanner sahifasidan chiqish (xohlasangiz)
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showError(String error) {
    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _statusMessage = error;
      _statusColor = Colors.red;
    });
    // 3 soniyadan keyin qayta skanerlashga ruxsat
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _statusMessage = "QR kodni ramkaga to'g'irlang...";
          _statusColor = Colors.black87;
        });
      }
    });
  }
}

class CheckScannerScreen extends StatefulWidget {
  const CheckScannerScreen({super.key});

  @override
  State<CheckScannerScreen> createState() => _CheckScannerScreenState();
}

class _CheckScannerScreenState extends State<CheckScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;

  String? _currentUserAgent;

  @override
  void initState() {
    super.initState();

    _initUserAgent();
  }

  Future<void> _initUserAgent() async {
    _currentUserAgent = await getDeviceUserAgent();
    debugPrint("Device User-Agent: $_currentUserAgent");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soliq Chek Skaner")),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (_isProcessing) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String? codeUrl = barcode.rawValue;

                if (codeUrl != null && codeUrl.contains("soliq.uz")) {
                  setState(() => _isProcessing = true);

                  await _getHtmlFromUrl(codeUrl);
                }
              }
            },
          ),

          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Future<void> _getHtmlFromUrl(String url) async {
    try {
      debugPrint("URL: $url");
      _currentUserAgent ??= await getDeviceUserAgent();

      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": _currentUserAgent!},
      );

      if (response.statusCode == 200) {
        String htmlContent = response.body;

        debugPrint("HTML uzunligi: ${htmlContent.length}");

        // TODO: Shu yerda HTMLni backendga yuborasiz
        // await sendToBackend(htmlContent);

        _showMessage("HTML muvaffaqiyatli olindi!", isError: false);
      } else {
        _showMessage(
          "Xatolik: Server ${response.statusCode} qaytardi",
          isError: true,
        );
      }
    } catch (e) {
      _showMessage("Internet xatoligi: $e", isError: true);
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isProcessing = false);
    }
  }

  void _showMessage(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
