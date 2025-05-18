import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/email_authentication_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
      title: "Sign in",
      onFinishProcessButtonAction: () {
        print("todo");
      },
    );
  }
}
