import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common.dart';

/// A Flutter widget that displays a popup menu button for changing the
/// application language.
class CdsChangeLanguage extends StatelessWidget {
  /// Constructs a `CdsChangeLanguage` widget.
  const CdsChangeLanguage({super.key});

  @override
  Widget build(final BuildContext context) => Builder(
        builder: (final BuildContext context) => PopupMenuButton<dynamic>(
          tooltip: 'Change language',
          itemBuilder: (final BuildContext context) => context.supportedLocales
              .map(
                (final Locale locale) => PopupMenuItem<dynamic>(
                  child: Text(locale.localeToLanguageName()),
                  onTap: () => context.setLocale(locale),
                ),
              )
              .toList(),
          child: const Icon(Icons.language),
        ),
      );
}
