

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestNavigatorObserver extends NavigatorObserver {
  int pushCount = 0;
  Route? lastPushedRoute;
  int popCount = 0;

  @override
  void didPush(Route route, Route? previousRoute) {
    pushCount++;
    lastPushedRoute = route;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    popCount++;
  }
}