import 'package:flutter/material.dart';

extension CustomBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}
