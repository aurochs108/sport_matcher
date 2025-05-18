import 'package:flutter/material.dart';

class AppTheme {
  static const _horizontalPadding = 24.0;
  static const _verticalPadding = 24.0;

  static EdgeInsets horizontalPadding() {
    return EdgeInsets.symmetric(horizontal: _horizontalPadding);
  }

  static EdgeInsets allPaddings(BuildContext context) {
    final safeArea = safeAreaPadding(context);
    return EdgeInsets.only(
      top: safeArea.top + _verticalPadding,
      bottom: safeArea.bottom + _verticalPadding,
      left: _horizontalPadding,
      right: _horizontalPadding,
    );
  }

  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
}
