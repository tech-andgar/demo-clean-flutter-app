import 'package:flutter/material.dart';

class CdsSnackBar {
  const CdsSnackBar._();

  static void show(final BuildContext context, final String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
