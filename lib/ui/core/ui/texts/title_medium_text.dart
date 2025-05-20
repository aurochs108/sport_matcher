import 'package:flutter/material.dart';

class TitleMediumText extends StatelessWidget {
  final String text;

  const TitleMediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}