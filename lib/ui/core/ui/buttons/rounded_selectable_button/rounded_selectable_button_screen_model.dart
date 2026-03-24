import 'package:flutter/material.dart';

class RoundedSelectableButtonScreenModel {
  bool _isSelected;
  final ValueChanged<bool>? _onSelectionChanged;

  Function()? onStateChanged;

  RoundedSelectableButtonScreenModel({
    bool initiallySelected = false,
    ValueChanged<bool>? onSelectionChanged,
  }) : _isSelected = initiallySelected,
       _onSelectionChanged = onSelectionChanged;

  bool get isSelected => _isSelected;

  VoidCallback? get onPressedAction =>
      _onSelectionChanged != null ? _onPressed : null;

  void _onPressed() {
    _isSelected = !_isSelected;
    _onSelectionChanged?.call(_isSelected);
    onStateChanged?.call();
  }

  Color get backgroundColor =>
      _isSelected ? Colors.lightBlueAccent : Colors.white;

  Color get borderColor => _isSelected ? Colors.blue : Colors.black;
}
