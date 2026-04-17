import 'package:flutter/material.dart';

class AsyncRoundedButtonScreenModel {
  VoidCallback? onStateChanged;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

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
