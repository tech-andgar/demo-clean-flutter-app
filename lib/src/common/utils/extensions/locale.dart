import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ExtensionLocale on Locale {
  String localeToLanguageName([bool toOriginal = true]) {
    final String type = toOriginal ? 'original' : 'translation';
    final Map<String, String> languageMap = {
      'en': 'core.languages.en.$type'.tr(),
      'es': 'core.languages.es.$type'.tr(),
      'pt': 'core.languages.pt.$type'.tr(),
    };
    return languageMap[languageCode] ?? 'Unknown';
  }
}
