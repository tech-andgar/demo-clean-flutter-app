import 'package:flutter/material.dart';

/// Extension method for the BuildContext class to access.
extension BuildContextExtension on BuildContext {
  /// Retrieves the current theme data from the context.
  ///
  /// Returns the current theme data.
  ThemeData get theme => Theme.of(this);
}

