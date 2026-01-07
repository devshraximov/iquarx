import 'package:go_router/go_router.dart';
import 'package:iquarix/iquarx_app.dart';

final class AppRouterImpl implements AppRouter {
  AppRouterImpl({
    required List<GoRoute> routes,
    String initialLocation = RouterKeys.initial,
    Listenable? refreshListenable,
    GoRouterRedirect? redirect,
  }) : _router = GoRouter(
         routes: routes,
         initialLocation: initialLocation,
         refreshListenable: refreshListenable,
         redirect: redirect,
         observers: [AppNavigatorObserver.instance],
       );

  final GoRouter _router;

  @override
  GoRouter get router => _router;

  @override
  void go(BuildContext context, {required String location, Object? extra}) {
    context.go(location, extra: extra);
  }

  @override
  void push(BuildContext context, {required String location, Object? extra}) {
    context.push(location, extra: extra);
  }

  @override
  void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
