import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CdsSnackBar {
  static void show(BuildContext context, String message) {
    final SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
