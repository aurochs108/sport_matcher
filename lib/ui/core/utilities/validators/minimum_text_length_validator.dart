import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

class MinimumTextLengthValidator extends AbstractTextValidator {
  MinimumTextLengthValidator({required int minimumLength})
      : _minimumLength = minimumLength;

  final int _minimumLength;

  @override
  String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return "Cannot be empty";
    } else if (text.length <= _minimumLength) {
      return "Cannot be less than $_minimumLength characters";
    }
    return null;
  }
}