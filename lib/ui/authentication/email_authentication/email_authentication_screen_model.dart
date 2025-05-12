import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/email_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/minimum_text_length_validator.dart';

class EmailAuthenticationScreenModel extends ChangeNotifier {
  final String title;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final AbstractTextValidator emailValidator;
  final AbstractTextValidator passwordValidator;

  bool isFinishProcesButtonActive = false;

  Function()? onStateChanged;

  EmailAuthenticationScreenModel({
    required this.title,
    AbstractTextValidator? emailValidator,
    AbstractTextValidator? passwordValidator,
  })  : emailValidator = emailValidator ?? EmailValidator(),
        passwordValidator = passwordValidator ??
           MinimumTextLengthValidator(minimumLength: 12) {
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
