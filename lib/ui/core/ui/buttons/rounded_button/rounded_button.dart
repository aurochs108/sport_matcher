import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button/rounded_button_screen_model.dart';

class RoundedButton extends StatelessWidget {
  final String _buttonTitle;
  final RoundedButtonScreenModel _viewModel;

  RoundedButton({
    super.key,
    required String buttonTitle,
    VoidCallback? onPressed,
  })  : _buttonTitle = buttonTitle,
        _viewModel = RoundedButtonScreenModel(onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 30;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _viewModel.onPressedAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: _viewModel.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: borderRadius,
          ),
        ),
        child: Text(
          _buttonTitle,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
