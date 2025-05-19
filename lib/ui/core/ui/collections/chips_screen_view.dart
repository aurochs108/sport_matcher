import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_selectable_button.dart';

class ChipsCollectionView extends StatelessWidget {
  final List<String> items;

  const ChipsCollectionView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppTheme.horizontalPadding(),
        child: Wrap(
          spacing: AppTheme.columnSpacingSmall,
          runSpacing: AppTheme.rowSpacingSmall,
          alignment: WrapAlignment.center,
          children: items.map((item) {
            return _activityButton(item);
          }).toList(),
        ),
      ),
    );
  }

  Widget _activityButton(String item) {
    return RoundedSelectableButton(
      title: item,
      onSelectionChanged: (isSelected) {
        // Handle the selection state here
        print('$item is selected: $isSelected');
      },
    );
  }
}
