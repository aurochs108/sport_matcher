import 'package:flutter/material.dart';

class AsyncRoundedButtonScreenModel {
  final Future<void> Function()? _onPressed;

  VoidCallback? onStateChanged;

  bool _isLoading = false;

  AsyncRoundedButtonScreenModel({
    Future<void> Function()? onPressed,
  }) : _onPressed = onPressed;

  bool get isLoading => _isLoading;

  bool get isEnabled => _onPressed != null && !_isLoading;

  Color get backgroundColor => isEnabled ? Colors.blue : Colors.grey;

  Future<void> handlePressed() async {
    _isLoading = true;
    onStateChanged?.call();
    try {
      await _onPressed?.call();
    } finally {
      _isLoading = false;
      onStateChanged?.call();
    }
  }
}
