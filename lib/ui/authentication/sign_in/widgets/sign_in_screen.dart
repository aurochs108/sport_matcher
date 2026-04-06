import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen.dart';
import 'package:sport_matcher/ui/authentication/sign_in/widgets/sign_in_screen_model.dart';

class SignInScreen extends StatelessWidget {
  final SignInScreenModel _viewModel;

  SignInScreen({super.key, SignInScreenModel? viewModel})
      : _viewModel = viewModel ?? SignInScreenModel();

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
      title: "Sign in",
      onFinishProcessButtonAction: (email, password) async {
        await _viewModel.register(email, password);
        if (_viewModel.errorMessage != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_viewModel.errorMessage!)),
          );
        }
      },
    );
  }
}
