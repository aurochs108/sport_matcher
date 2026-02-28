import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

class TextLengthValidator extends AbstractTextValidator {
  TextLengthValidator({required int minimumLength, required int maximumLength})
      : _minimumLength = minimumLength,
        _maximumLength = maximumLength;

  final int _minimumLength;
  final int _maximumLength;

  @override
  String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return "Cannot be empty";
    } else if (text.length < _minimumLength) {
      return "Cannot be less than $_minimumLength characters";
    } else if (text.length > _maximumLength) {
      return "Cannot be more than $_maximumLength characters";
    }
    return null;
  }
}