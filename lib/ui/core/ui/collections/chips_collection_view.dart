import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_selectable_button/rounded_selectable_button.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_collection_view_model.dart';

class ChipsCollectionView extends StatefulWidget {
  final ChipsCollectionViewModel viewModel;

  ChipsCollectionView({
    super.key,
    required Map<String, bool> items,
    void Function(String, bool)? onSelectionChanged,
  }) : viewModel = ChipsCollectionViewModel(
          items: items,
          onSelectionChanged: onSelectionChanged,
        );

  @override
  State<ChipsCollectionView> createState() => _ChipsCollectionViewState();
}

class _ChipsCollectionViewState extends State<ChipsCollectionView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.onStateChanged = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.horizontalPadding(),
      child: Wrap(
        spacing: AppTheme.columnSpacingSmall,
        runSpacing: AppTheme.rowSpacingSmall,
        alignment: WrapAlignment.center,
        children:
            widget.viewModel.itemKeys.map((item) {
              return _activityButton(item);
            }).toList(),
      ),
    );
  }

  Widget _activityButton(String item) {
    return RoundedSelectableButton(
      title: item,
      initiallySelected: widget.viewModel.isSelected(item),
      onSelectionChanged: widget.viewModel.getOnSelectionChanged(item),
    );
  }
}
