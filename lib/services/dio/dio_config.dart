import 'package:dio/dio.dart';
import 'package:iquarix/iquarx_app.dart';

class DioConfig {
  final Dio dio;
  final LocalSource _localSource;

  DioConfig(this._localSource, {bool isDebug = false})
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      ) {
    dio.interceptors.add(TokenInterceptor(dio: dio, localSource: _localSource));

    // if (isDebug) {
    //   final aliceDioAdapter = AliceDioAdapter();
    //
    //   final configuration = AliceConfiguration(
    //     navigatorKey: NavigationService.navigatorKey,
    //     showNotification: false,
    //   );
    //   _alice = Alice(configuration: configuration)..addAdapter(aliceDioAdapter);
    //
    //   dio.interceptors.add(aliceDioAdapter);
    // }

    assert(() {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          logPrint: (log) {
            debugPrint("$log");
          },
        ),
      );

      return true;
    }());
  }
}
