import 'package:flutter/material.dart';

class AsyncRoundedButtonScreenModel {
  VoidCallback? onStateChanged;

  bool _hasCallback = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isEnabled => _hasCallback && !_isLoading;

  Color get backgroundColor => isEnabled ? Colors.blue : Colors.grey;

  set hasCallback(bool value) {
    if (_hasCallback == value) return;
    _hasCallback = value;
    onStateChanged?.call();
  }

  Future<void> handlePressed(Future<void> Function() onPressed) async {
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
