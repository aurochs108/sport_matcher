import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final AbstractTextValidator? validator;

  const PasswordTextField({
    super.key,
    required  this.controller,
    this.validator,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscurePassword,
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text("Password"),
        floatingLabelStyle: TextStyle(color: Colors.blue),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      validator: (value) {
        return widget.validator?.validate(value);
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
    );
  }
}
