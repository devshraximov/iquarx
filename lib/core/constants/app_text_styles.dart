import 'package:iquarix/iquarx_app.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle largeTitleSemiBold = const TextStyle(
    fontFamily: AppFonts.archivo,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 28 / 24,
    letterSpacing: -0.02 * 24,
  );
  static TextStyle bodyRegular = const TextStyle(
    fontFamily: AppFonts.archivo,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: -0.01 * 14,
  );
  static TextStyle controlInputLabel1 = const TextStyle(
    fontFamily: AppFonts.archivo,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 16 / 14,
    letterSpacing: -0.01 * 14,
  );
  static TextStyle controlInputValue = const TextStyle(
    fontFamily: AppFonts.archivo,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.65,
    letterSpacing: 0.2,
  );
}
