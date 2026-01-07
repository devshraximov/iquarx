import 'package:iquarix/iquarx_app.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: const SizedBox(
        height: 24,
        width: 24,
        child: Center(child: Icon(Icons.clear, size: 24, color: Colors.black)),
      ),
    );
  }
}
