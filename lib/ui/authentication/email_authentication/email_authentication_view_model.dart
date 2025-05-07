import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/utilities/validators/email_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/minimum_text_length_validator.dart';

class EmailAuthenticationViewModel extends ChangeNotifier {
  final String title;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final emailValidator = EmailValidator();
  final passwordValidator = MinimumTextLengthValidator(minimumLength: 12);

  bool isFinishProcesButtonActive = false;

  String? emailError;
  String? passwordError;
  Function()? onStateChanged;

  EmailAuthenticationViewModel({required this.title}) {
    emailTextController.addListener(_updateButtonState);
    passwordTextController.addListener(_updateButtonState);
  }
  
  VoidCallback? getFinishProcessButtonAction() {
    if (isFinishProcesButtonActive) {
      return () =>
          print('Email authentication screen _onFinishProcessSelected');
    } else {
      return null;
    }
  }

  void _updateButtonState() {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    final isEmailValid = emailValidator.validate(email) == null;
    final isPasswordValid = passwordValidator.validate(password) == null;

    final newButtonState = isEmailValid && isPasswordValid;

    if (isFinishProcesButtonActive != newButtonState) {
      isFinishProcesButtonActive = newButtonState;
      onStateChanged?.call();
    }
  }

  void disposeControllers() {
    emailTextController.removeListener(_updateButtonState);
    emailTextController.dispose();
    passwordTextController.removeListener(_updateButtonState);
    passwordTextController.dispose();
  }
}
