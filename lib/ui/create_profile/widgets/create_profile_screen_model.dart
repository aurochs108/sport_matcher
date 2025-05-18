import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/minimum_text_length_validator.dart';

class CreateProfileScreenModel extends ChangeNotifier {
  final nameTextController = TextEditingController();
  final AbstractTextValidator nameValidator;

  CreateProfileScreenModel({
    AbstractTextValidator? nameValidator,
  }) : nameValidator = nameValidator ?? MinimumTextLengthValidator(minimumLength: 2) {
    nameTextController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    
  }
}