import 'package:go_router/go_router.dart';
import 'package:iquarix/iquarx_app.dart';

final appRoutes = <GoRoute>[
  GoRoute(
    path: RouterKeys.initial,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: RouterKeys.phoneAuth,
    builder: (context, state) => const PhoneAuthPage(),
  ),
  GoRoute(
    path: RouterKeys.otp,
    builder: (context, state) {
      final arguments = state.extra as DataMap;
      return OtpPage(arguments: arguments);
    },
  ),
  GoRoute(path: RouterKeys.home, builder: (context, state) => const HomePage()),
];
