import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _navigateToCreateProfile(BuildContext buildContext) {
    Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buildContext) => CreateProfileScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
        title: "Sign up",
        onFinishProcessButtonAction: () {
          _navigateToCreateProfile(context);
        });
  }
}
