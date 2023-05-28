import 'package:flutter/material.dart';

Color colorForResult(double result) {
  if (result < 50) {
    return Colors.red;
  }
  if (result >= 50 && result < 75) {
    return Colors.yellow.shade700;
  }
  return Colors.green;
}
