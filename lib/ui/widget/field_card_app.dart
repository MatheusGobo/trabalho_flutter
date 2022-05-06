import 'package:flutter/material.dart';

class FieldCardApp extends StatelessWidget {
  final double width;
  final String prefix;
  final String text;

  const FieldCardApp({
    required this.width,
    required this.prefix,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: prefix,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.grey[700], borderRadius: BorderRadius.circular(7)),
    );
  }
}