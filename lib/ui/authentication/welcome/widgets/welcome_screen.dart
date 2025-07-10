import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/authentication/sign_in/widgets/sign_in_screen.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _navigateToSignIn(BuildContext buildContext) {
    Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buildContext) => SignInScreen(),
    ));
  }

  void _navigateToSignUp(BuildContext buildContext) {
    Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buildContext) => SignUpScreen(),
    ));
  }

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
                  child: Image.asset(
                    'lib/ui/authentication/assets/logo.png',
                  ),
                ),
                const Spacer(),
                RoundedButton(
                    buttonTitle: "Sign in",
                    onPressed: () {
                      _navigateToSignIn(context);
                    }),
                RoundedButton(
                    buttonTitle: "Sign up",
                    onPressed: () {
                      _navigateToSignUp(context);
                    })
              ],
            )));
  }
}
