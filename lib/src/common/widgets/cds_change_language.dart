import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common.dart';

/// A Flutter widget that displays a popup menu button for changing the
/// application language.
class CdsChangeLanguage extends StatelessWidget {
  /// Constructs a `CdsChangeLanguage` widget.
  const CdsChangeLanguage({super.key});

  List<PopupMenuEntry<Widget>> _itemsPopupMenu(final BuildContext context) {
    return context.supportedLocales.map(
      (final locale) {
        return PopupMenuItem<Widget>(
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
        return PopupMenuButton(
          tooltip: 'Change language',
          itemBuilder: _itemsPopupMenu,
          child: const Icon(Icons.language),
        );
      },
    );
  }
}
