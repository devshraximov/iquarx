import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver._();

  static final AppNavigatorObserver instance = AppNavigatorObserver._();

  final List<Route<dynamic>> _routeStack = [];

  List<String?> get currentStack =>
      _routeStack.map((r) => r.settings.name).toList();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _routeStack.add(route);
    _log();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _routeStack.remove(route);
    _log();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _routeStack.remove(route);
    _log();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    final index = _routeStack.indexOf(oldRoute!);
    if (index != -1 && newRoute != null) {
      _routeStack[index] = newRoute;
    }
    _log();
  }

  void _log() {
    debugPrint(
      'NAV STACK: ${_routeStack.map((r) => r.settings.name).toList()}',
    );
  }
}
