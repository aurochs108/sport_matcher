import 'package:flutter/material.dart';

class AppTheme {
  // Paddings
  static const _horizontalPadding = 24.0;
  static const _verticalPadding = 24.0;

  static EdgeInsets horizontalPadding() {
    return EdgeInsets.symmetric(horizontal: _horizontalPadding);
  }

  static EdgeInsets allPaddings(BuildContext context) {
    final safeArea = _safeAreaPadding(context);
    return EdgeInsets.only(
      top: safeArea.top + _verticalPadding,
      bottom: safeArea.bottom + _verticalPadding,
      left: _horizontalPadding,
      right: _horizontalPadding,
    );
  }

  static EdgeInsets horizontalAndBottom(BuildContext context) {
    final safeArea = _safeAreaPadding(context);
    return EdgeInsets.only(
      bottom: safeArea.bottom + _verticalPadding,
      left: _horizontalPadding,
      right: _horizontalPadding,
    );
  }

  static EdgeInsets _safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // Spacings

  static const double columnSpacingSmall = 8.0;
  static const double columnSpacingMedium = 16.0;

  static const double rowSpacingSmall = 8.0;
}
