import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/async_rounded_button/async_rounded_button_screen_model.dart';

class AsyncRoundedButton extends StatefulWidget {
  final String buttonTitle;
  final AsyncRoundedButtonScreenModel _viewModel;

  AsyncRoundedButton({
    super.key,
    required String buttonTitle,
    Future<void> Function()? onPressed,
  })  : buttonTitle = buttonTitle,
        _viewModel = AsyncRoundedButtonScreenModel(onPressed: onPressed);

  @override
  State<AsyncRoundedButton> createState() => _AsyncRoundedButtonState();
}

class _AsyncRoundedButtonState extends State<AsyncRoundedButton> {
  Future<void> _handlePressed() async {
    setState(() {});
    await widget._viewModel.handlePressed();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget._viewModel.isEnabled ? _handlePressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget._viewModel.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.buttonBorderRadius,
          ),
        ),
        child: widget._viewModel.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                widget.buttonTitle,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
