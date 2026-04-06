import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen_model.dart';
import 'package:sport_matcher/ui/profile/create_profile/widgets/create_profile_screen.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpScreenModel _viewModel;

  SignUpScreen({super.key, SignUpScreenModel? viewModel})
      : _viewModel = viewModel ?? SignUpScreenModel();

  void _navigateToCreateProfile(BuildContext buildContext) {
    Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buildContext) => CreateProfileScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return EmailAuthenticationScreen(
      title: "Sign up",
      onFinishProcessButtonAction: (email, password) async {
        await _viewModel.register(email, password);
        if (_viewModel.errorMessage != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_viewModel.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        if (context.mounted) {
          _navigateToCreateProfile(context);
        }
      },
    );
  }
}
