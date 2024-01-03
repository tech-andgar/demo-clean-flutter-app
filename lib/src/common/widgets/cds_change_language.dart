import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class CdsChangeLanguage extends StatelessWidget {
  const CdsChangeLanguage(this.setState, {super.key});
  final VoidCallback setState;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PopupMenuButton(
          tooltip: 'Change language',
          itemBuilder: (context) {
            return context.supportedLocales.map((Locale locale) {
              return PopupMenuItem(
                child: Text(locale.localeToLanguageName()),
                onTap: () {
                  context.setLocale(locale);
                  setState();
                },
              );
            }).toList();
          },
          child: const Icon(Icons.language),
        );
      },
    );
  }
}
