import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    'lib/ui/authentication/assets/logo.png',
                  ),
                ),
                const Spacer(),
                roundedButton(
                    buttonTitle: "Sign in",
                    onPressed: () {
                      _navigateToSignIn(context);
                    }),
                roundedButton(
                    buttonTitle: "Sign up",
                    onPressed: () {
                      _navigateToSignUp(context);
                    })
              ],
            )));
  }
}
