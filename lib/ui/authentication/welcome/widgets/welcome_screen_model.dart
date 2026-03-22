import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/sign_in/widgets/sign_in_screen.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen.dart';

class WelcomeScreenModel {
  void navigateToSignIn(BuildContext buildContext) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }

  void navigateToSignUp(BuildContext buildContext) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(builder: (_) => SignUpScreen()),
    );
  }
}
