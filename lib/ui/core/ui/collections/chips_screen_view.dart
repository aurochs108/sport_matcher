import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_selectable_button.dart';


class ChipsCollectionView extends StatefulWidget {
  final Map<String, bool> items;
  final void Function(String, bool) onSelectionChanged;

  ChipsCollectionView({
    super.key,
    required Map<String, bool> items,
    required this.onSelectionChanged,
  }) : items = Map<String, bool>.from(items);

  @override
  State<ChipsCollectionView> createState() => _ChipsCollectionViewState();
}

class _ChipsCollectionViewState extends State<ChipsCollectionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.horizontalPadding(),
      child: Wrap(
        spacing: AppTheme.columnSpacingSmall,
        runSpacing: AppTheme.rowSpacingSmall,
        alignment: WrapAlignment.center,
        children: widget.items.keys.map((item) {
          return _activityButton(item);
        }).toList(),
      ),
    );
  }

  Widget _activityButton(String item) {
    return RoundedSelectableButton(
      title: item,
      onSelectionChanged: (isSelected) {
        setState(() {
          widget.items[item] = isSelected;
        });
        widget.onSelectionChanged(item, isSelected);
      },
    );
  }
}
