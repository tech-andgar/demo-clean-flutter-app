import 'package:flutter/material.dart';

class CdsSnackBar {
  static void show(BuildContext context, String message) {
    final SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
