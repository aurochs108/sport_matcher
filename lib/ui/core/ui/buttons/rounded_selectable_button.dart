import 'package:flutter/material.dart';

class RoundedSelectableButton extends StatefulWidget {
  final String title;
  final ValueChanged<bool> onSelectionChanged;

  const RoundedSelectableButton(
      {super.key, required this.title, required this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return _RoundedSelectableButtonState();
  }
}

class _RoundedSelectableButtonState extends State<RoundedSelectableButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelectionChanged(isSelected);
      },
      style: _getButtonStyle(),
      child: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    final backgroundColor = _getButtonBackgroundColor();
    final borderColor = _getButtonBorderColor();
  
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      side: BorderSide(color: borderColor, width: 1),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Color _getButtonBackgroundColor() {
    if (isSelected) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.white;
    }
  }

  Color _getButtonBorderColor() {
    if (isSelected) {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }
}
