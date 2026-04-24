import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen_model.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/async_rounded_button/async_rounded_button.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/password_text_field.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';

class EmailAuthenticationScreen extends StatefulWidget {
  final String title;
  final Future<void> Function(String email, String password)
      onFinishProcessButtonAction;

  const EmailAuthenticationScreen({
    super.key,
    required this.title,
    required this.onFinishProcessButtonAction,
  });

  @override
  State<EmailAuthenticationScreen> createState() {
    return _EmailAuthenticationScreenState();
  }
}

class _EmailAuthenticationScreenState extends State<EmailAuthenticationScreen> {
  late final EmailAuthenticationScreenModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = EmailAuthenticationScreenModel(
      title: widget.title,
      onFinishProcessButtonAction: widget.onFinishProcessButtonAction,
    );
    _viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    _viewModel.disposeControllers();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_viewModel.title)),
      body: Padding(
        padding: AppTheme.allPaddings(context),
        child: Column(
          children: [
            Expanded(
              child: Column(
                spacing: AppTheme.columnSpacingMedium,
                children: [
                  PlainTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _viewModel.emailTextController,
                    title: "Email",
                    validator: _viewModel.emailValidator,
                  ),
                  PasswordTextField(
                    controller: _viewModel.passwordTextController,
                    validator: _viewModel.passwordValidator,
                  ),
                ],
              ),
            ),
            AsyncRoundedButton(
              buttonTitle: _viewModel.title,
              onPressed: _viewModel.getFinishProcessButtonAction(),
            ),
          ],
        ),
      ),
    );
  }
}
