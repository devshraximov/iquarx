import 'package:easy_localization/easy_localization.dart';
import 'package:iquarix/iquarx_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: AppTheme.initial,
        builder: (theme, darkTheme) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1)),
            child: MaterialApp.router(
              routerConfig: sl<AppRouter>().router,
              debugShowCheckedModeBanner: false,
              title: 'QRX',
              darkTheme: darkTheme,
              theme: theme,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
