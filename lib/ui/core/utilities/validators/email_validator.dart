import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

class EmailValidator extends AbstractTextValidator {
  static final _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{1,63}))$');
  @override
  String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return "Cannot be empty";
    } else if (!_emailRegex.hasMatch(text)) {
      return "Invalid email address";
    } else if (text.length > 254) {
      return "Cannot be more than 254 characters";
    }
    return null;
  }
}
