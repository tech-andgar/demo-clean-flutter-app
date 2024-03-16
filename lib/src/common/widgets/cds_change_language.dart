import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class CdsChangeLanguage extends StatelessWidget {
  const CdsChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => PopupMenuButton(
          tooltip: 'Change language',
          itemBuilder: (context) => context.supportedLocales
              .map(
                // ignore: inference_failure_on_instance_creation
                (Locale locale) => PopupMenuItem(
                  child: Text(locale.localeToLanguageName()),
                  onTap: () => context.setLocale(locale),
                ),
              )
              .toList(),
          child: const Icon(Icons.language),
        ),
      );
}
