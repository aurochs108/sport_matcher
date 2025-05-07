import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/email_authentication_view_model.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/password_text_field.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';

class EmailAuthenticationScreen extends StatefulWidget {
  EmailAuthenticationScreen({super.key, required String title})
      : viewModel = EmailAuthenticationViewModel(title: title);

  final EmailAuthenticationViewModel viewModel;

  @override
  State<EmailAuthenticationScreen> createState() {
    return _EmailAuthenticationScreenState();
  }
}

class _EmailAuthenticationScreenState extends State<EmailAuthenticationScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.onStateChanged = () {
      setState(() {}); 
    };
  }

  @override
  void dispose() {
    widget.viewModel.disposeControllers();
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  PlainTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.viewModel.emailTextController,
                    title: "Email",
                    validator: widget.viewModel.emailValidator,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PasswordTextField(
                    controller: widget.viewModel.passwordTextController,
                    validator: widget.viewModel.passwordValidator,
                  )
                ],
              ),
            ),
            roundedButton(
              buttonTitle: widget.viewModel.title,
              onPressed: widget.viewModel.getFinishProcessButtonAction()
            )
          ],
        ),
      ),
    );
  }
}
