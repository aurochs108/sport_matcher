

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestNavigatorObserver extends NavigatorObserver {
  int pushCount = 0;
  Route? lastPushedRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    pushCount++;
    lastPushedRoute = route;
  }
}