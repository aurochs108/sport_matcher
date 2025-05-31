import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

class PlainTextField extends StatelessWidget {
  final TextInputType? _keyboardType;
  final TextEditingController _controller;
  final String _title;
  final AbstractTextValidator? _validator;
  final TextCapitalization _textCapitalization;

  const PlainTextField({
    super.key,
    TextInputType? keyboardType,
    required TextEditingController controller,
    required String title,
    AbstractTextValidator? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  })  : _keyboardType = keyboardType,
        _controller = controller,
        _title = title,
        _validator = validator,
        _textCapitalization = textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: _textCapitalization,
      keyboardType: _keyboardType,
      controller: _controller,
      decoration: InputDecoration(
        label: Text(_title),
        floatingLabelStyle: TextStyle(color: Colors.blue),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      validator: (value) {
        return _validator?.validate(value);
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
    );
  }
}
