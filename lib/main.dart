import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:iquarix/app/app.dart';
import 'package:iquarix/iquarx_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Yandex map api key -> aed11bab-995d-4af2-bf68-ecdc4a115642

  await EasyLocalization.ensureInitialized();
  await setupRouter();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
      path: 'assets/languages',
      fallbackLocale: const Locale('ru', 'RU'),
      startLocale: const Locale('ru', 'RU'),
      saveLocale: true,
      child: const App(),
    ),
  );
}
