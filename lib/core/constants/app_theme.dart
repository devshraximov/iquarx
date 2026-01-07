import 'package:iquarix/iquarx_app.dart';

abstract final class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.deepPurple,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple,
  );

  static AdaptiveThemeMode initial = AdaptiveThemeMode.light;
}
