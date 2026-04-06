import 'package:flutter/material.dart';
import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen.dart';

class SignInScreen extends StatelessWidget {
  final AuthApi _authApi;

  SignInScreen({super.key, AuthApi? authApi})
      : _authApi = authApi ?? AuthApi();

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
      title: "Sign in",
      onFinishProcessButtonAction: (email, password) async {
        try {
          await _authApi.register(
            EmailRegistrationRequest(email: email, password: password),
          );
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration failed: $e')),
            );
          }
        }
      },
    );
  }
}
