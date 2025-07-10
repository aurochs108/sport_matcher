import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double borderRadius = 30;

    Color getBackgroundColor() {
      if (onPressed == null) {
        return Colors.grey;
      } else {
        return Colors.blue;
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: borderRadius,
          ),
        ),
        child: Text(
          buttonTitle,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}