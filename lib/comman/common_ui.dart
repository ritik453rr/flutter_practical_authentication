import 'package:flutter/material.dart';

class CommonUI {
  static text(
    String text, {
    double fontSize = 16,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
