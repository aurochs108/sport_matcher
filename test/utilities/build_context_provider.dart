import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class BuildContextProvider {
  static Future<BuildContext> get(WidgetTester tester) async {
    late BuildContext buildContext;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            buildContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    return buildContext;
  }
}