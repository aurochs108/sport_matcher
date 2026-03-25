import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button/rounded_button.dart';
import 'package:sport_matcher/ui/authentication/welcome/widgets/welcome_screen_model.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeScreenModel _viewModel;

  WelcomeScreen({super.key}) : _viewModel = WelcomeScreenModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppTheme.allPaddings(context),
        child: Column(
          spacing: AppTheme.columnSpacingSmall,
          children: [
            Padding(
              padding: AppTheme.horizontalPadding(),
              child: Image.asset('lib/ui/authentication/assets/logo.png'),
            ),
            const Spacer(),
            RoundedButton(
              buttonTitle: "Sign in",
              onPressed: () {
                _viewModel.navigateToSignIn(context);
              },
            ),
            RoundedButton(
              buttonTitle: "Sign up",
              onPressed: () {
                _viewModel.navigateToSignUp(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
