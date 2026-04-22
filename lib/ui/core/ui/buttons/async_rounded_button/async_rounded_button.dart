import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/async_rounded_button/async_rounded_button_screen_model.dart';

class AsyncRoundedButton extends StatefulWidget {
  final String _buttonTitle;
  final Future<void> Function()? _onPressed;

  const AsyncRoundedButton({
    super.key,
    required String buttonTitle,
    Future<void> Function()? onPressed,
  })  : _buttonTitle = buttonTitle,
        _onPressed = onPressed;

  @override
  State<AsyncRoundedButton> createState() => _AsyncRoundedButtonState();
}

class _AsyncRoundedButtonState extends State<AsyncRoundedButton>
    with SingleTickerProviderStateMixin {
  late final AsyncRoundedButtonScreenModel _viewModel;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool _isHandlingPress = false;

  @override
  void initState() {
    super.initState();
    _viewModel = AsyncRoundedButtonScreenModel();
    _viewModel.onStateChanged = () => setState(() {});
    _viewModel.onPressed = widget._onPressed;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(AsyncRoundedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _viewModel.onPressed = widget._onPressed;
  }

  @override
  void dispose() {
    _viewModel.onStateChanged = null;
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handlePressed() async {
    if (_isHandlingPress || !_viewModel.isEnabled) return;

    setState(() {
      _isHandlingPress = true;
    });

    try {
      await _animationController.forward();
      await _viewModel.handlePressed();
    } finally {
      if (mounted) {
        await _animationController.reverse();
        setState(() {
          _isHandlingPress = false;
        });
      } else {
        _isHandlingPress = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = _viewModel.isEnabled && !_isHandlingPress;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? _handlePressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.blue : Colors.grey,
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
            if (_viewModel.isLoading && _animationController.isCompleted) {
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
                widget._buttonTitle,
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
