import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common.dart';

/// A Flutter widget that displays a popup menu button for changing the
/// application language.
class CdsChangeLanguage extends StatelessWidget {
  /// Constructs a `CdsChangeLanguage` widget.
  const CdsChangeLanguage({super.key});

  List<PopupMenuEntry<Object>> _widgetItems(final BuildContext context) {
    return context.supportedLocales.map(
      (final locale) {
        return PopupMenuItem<Object>(
          child: Text(locale.localeToLanguageName()),
          onTap: () => context.setLocale(locale),
        );
      },
    ).toList();
  }

  @override
  Widget build(final BuildContext context) {
    return Builder(
      builder: (final context) {
        return PopupMenuButton<Object>(
          tooltip: 'Change language',
          itemBuilder: _widgetItems,
          child: const Icon(Icons.language),
        );
      },
    );
  }
}
