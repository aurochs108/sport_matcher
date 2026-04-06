import 'package:flutter/material.dart';

class AsyncRoundedButtonScreenModel {
  final Future<void> Function()? _onPressed;

  bool isLoading = false;

  AsyncRoundedButtonScreenModel({
    Future<void> Function()? onPressed,
  }) : _onPressed = onPressed;

  bool get isEnabled => _onPressed != null && !isLoading;

  Color get backgroundColor => isEnabled ? Colors.blue : Colors.grey;

  Future<void> handlePressed() async {
    isLoading = true;
    try {
      await _onPressed?.call();
    } finally {
      isLoading = false;
    }
  }
}
