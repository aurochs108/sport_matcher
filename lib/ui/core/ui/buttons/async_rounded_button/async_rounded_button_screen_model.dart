import 'package:flutter/material.dart';

class AsyncRoundedButtonScreenModel {
  VoidCallback? onStateChanged;

  Future<void> Function()? _onPressed;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isEnabled => _onPressed != null && !_isLoading;

  Color get backgroundColor => isEnabled ? Colors.blue : Colors.grey;

  set onPressed(Future<void> Function()? value) {
    if (_onPressed == value) return;
    _onPressed = value;
    onStateChanged?.call();
  }

  Future<void> handlePressed() async {
    if (_isLoading) return;
    final onPressed = _onPressed;
    if (onPressed == null) return;
    _isLoading = true;
    onStateChanged?.call();
    try {
      await onPressed();
    } finally {
      _isLoading = false;
      onStateChanged?.call();
    }
  }
}
