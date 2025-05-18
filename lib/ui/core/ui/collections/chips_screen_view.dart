import 'package:flutter/material.dart';

class ChipsCollectionView extends StatelessWidget {
 final List<String> items;

  const ChipsCollectionView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: Colors.blue.shade100,
            );
          }).toList(),
        ),
      );
  }
}
