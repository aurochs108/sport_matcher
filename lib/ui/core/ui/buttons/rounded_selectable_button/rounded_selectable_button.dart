import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_selectable_button/rounded_selectable_button_screen_model.dart';

class RoundedSelectableButton extends StatefulWidget {
  final String _title;
  final RoundedSelectableButtonScreenModel _viewModel;

  RoundedSelectableButton({
    super.key,
    required String title,
    bool initiallySelected = false,
    ValueChanged<bool>? onSelectionChanged,
  }) : _title = title,
       _viewModel = RoundedSelectableButtonScreenModel(
         initiallySelected: initiallySelected,
         onSelectionChanged: onSelectionChanged,
       );

  @override
  State<StatefulWidget> createState() {
    return _RoundedSelectableButtonState();
  }
}

class _RoundedSelectableButtonState extends State<RoundedSelectableButton> {
  @override
  void initState() {
    super.initState();
    widget._viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget._viewModel;

    return ElevatedButton(
      onPressed: viewModel.onPressedAction,
      style: _getButtonStyle(),
      child: Text(widget._title, style: const TextStyle(color: Colors.black)),
    );
  }

  ButtonStyle _getButtonStyle() {
    final viewModel = widget._viewModel;

    return ElevatedButton.styleFrom(
      backgroundColor: viewModel.backgroundColor,
      side: BorderSide(color: viewModel.borderColor, width: 1),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
