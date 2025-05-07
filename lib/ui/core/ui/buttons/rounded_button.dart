import 'package:flutter/material.dart';

Widget roundedButton(
    {required String buttonTitle, required VoidCallback? onPressed}) {
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
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    ),
  );
}
