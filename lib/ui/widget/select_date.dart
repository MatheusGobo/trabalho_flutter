import 'package:flutter/material.dart';

class SelectDate {
  Future<DateTime?> selectDate({required BuildContext context, required DateTime actualDate}) async{
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: actualDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    return selected;
  }

  String formatTextDate({required DateTime date}) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
  }
}