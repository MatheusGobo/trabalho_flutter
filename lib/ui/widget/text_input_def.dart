import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';

class TextInputDef extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String> validator;

  const TextInputDef({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ThemeClass.primaryColor, width: 2)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ThemeClass.secondColor),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: hintText ?? labelText),
    );
  }
}
