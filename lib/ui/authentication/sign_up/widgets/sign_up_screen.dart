import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/email_authentication_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
        title: "Sign up",
        onFinishProcessButtonAction: () {
          print("todo");
        });
  }
}
