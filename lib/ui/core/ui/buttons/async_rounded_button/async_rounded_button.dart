import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/async_rounded_button/async_rounded_button_screen_model.dart';

class AsyncRoundedButton extends StatefulWidget {
  final String buttonTitle;
  final AsyncRoundedButtonScreenModel _viewModel;

  AsyncRoundedButton({
    super.key,
    required this.buttonTitle,
    Future<void> Function()? onPressed,
  }) : _viewModel = AsyncRoundedButtonScreenModel(onPressed: onPressed);

  @override
  State<AsyncRoundedButton> createState() => _AsyncRoundedButtonState();
}

class _AsyncRoundedButtonState extends State<AsyncRoundedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handlePressed() async {
    await _animationController.forward();
    setState(() {});
    await widget._viewModel.handlePressed();
    if (mounted) {
      setState(() {});
      await _animationController.reverse();
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
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            if (widget._viewModel.isLoading &&
                _animationController.isCompleted) {
              return const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              );
            }
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                widget.buttonTitle,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
