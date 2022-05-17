import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';

class FieldCardApp extends StatelessWidget {
  final String prefix;
  final String text;

  const FieldCardApp({
    required this.prefix,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: prefix,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: ThemeClass.secondColor,
            ),
          ),
          fillColor: Colors.white,
        ),
        child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
      ),
    );
  }
}
