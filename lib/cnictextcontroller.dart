import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CNICFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0 && newValue.text.length <= 5) {
      // Insert a dash after the first 5 numbers
      if (newValue.text.length == 5 && newValue.text[4] != '-') {
        return TextEditingValue(
          text: '${newValue.text.substring(0, 5)}-',
          selection: TextSelection.collapsed(offset: 6),
        );
      }
    } else if (newValue.text.length > 6 && newValue.text.length <= 12) {
      // Insert a dash after the next 7 numbers
      if (newValue.text.length == 12 && newValue.text[11] != '-') {
        return TextEditingValue(
          text: '${newValue.text.substring(0, 12)}-',
          selection: TextSelection.collapsed(offset: 13),
        );
      }
    }

    // Remove any non-digit characters
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit the length to 13 characters
    if (cleanedText.length > 13) {
      cleanedText = cleanedText.substring(0, 13);
    }

    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: cleanedText.length),
    );
  }
}