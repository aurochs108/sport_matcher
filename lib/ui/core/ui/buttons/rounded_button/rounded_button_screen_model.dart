import 'package:flutter/material.dart';

class RoundedButtonScreenModel {
  final VoidCallback? _onPressed;

  RoundedButtonScreenModel({
    VoidCallback? onPressed,
  }) : _onPressed = onPressed;

  VoidCallback? get onPressedAction => _onPressed;

  Color get backgroundColor => _onPressed != null ? Colors.blue : Colors.grey;
}
