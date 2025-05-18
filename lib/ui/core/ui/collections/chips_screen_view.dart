import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';

class ChipsCollectionView extends StatelessWidget {
  final List<String> items;

  const ChipsCollectionView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            AppTheme.horizontalPadding(),
        child: Wrap(
          spacing: AppTheme.columnSpacingSmall,
          runSpacing: AppTheme.rowSpacingSmall,
          alignment:
              WrapAlignment.center,
          children: items.map((item) {
            return Chip(
              label: Text(
                item,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              shape: const StadiumBorder(),
              side: const BorderSide(color: Colors.black, width: 1),
            );
          }).toList(),
        ),
      ),
    );
  }
}
