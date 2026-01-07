import 'package:go_router/go_router.dart';
import 'package:iquarix/iquarx_app.dart';

abstract class AppRouter {
  GoRouter get router;

  void go(BuildContext context, {required String location, Object? extra});

  void push(BuildContext context, {required String location, Object? extra});

  void pop(BuildContext context);
}
