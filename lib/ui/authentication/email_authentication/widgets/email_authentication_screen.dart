import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen_model.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/password_text_field.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';

class EmailAuthenticationScreen extends StatefulWidget {
  final EmailAuthenticationScreenModel _viewModel;

  EmailAuthenticationScreen(
      {super.key, required String title, required onFinishProcessButtonAction})
      : _viewModel = EmailAuthenticationScreenModel(
            title: title,
            onFinishProcessButtonAction: onFinishProcessButtonAction);

  @override
  State<EmailAuthenticationScreen> createState() {
    return _EmailAuthenticationScreenState();
  }
}

class _EmailAuthenticationScreenState extends State<EmailAuthenticationScreen> {
  @override
  void initState() {
    super.initState();
    widget._viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    widget._viewModel.disposeControllers();
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._viewModel.title),
      ),
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
                    controller: widget._viewModel.emailTextController,
                    title: "Email",
                    validator: widget._viewModel.emailValidator,
                  ),
                  PasswordTextField(
                    controller: widget._viewModel.passwordTextController,
                    validator: widget._viewModel.passwordValidator,
                  )
                ],
              ),
            ),
            RoundedButton(
                buttonTitle: widget._viewModel.title,
                onPressed: widget._viewModel.getFinishProcessButtonAction())
          ],
        ),
      ),
    );
  }
}
