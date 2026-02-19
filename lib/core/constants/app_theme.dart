import 'package:iquarix/core/constants/app_fonts.dart';
import 'package:iquarix/iquarx_app.dart';

abstract final class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppFonts.archivo,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppFonts.archivo,
    scaffoldBackgroundColor: Colors.black,
  );

  static AdaptiveThemeMode initial = AdaptiveThemeMode.light;
}
