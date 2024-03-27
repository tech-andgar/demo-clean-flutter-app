import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Extension method for the Locale class to provide a human-readable
/// representation of the language name.
extension LocaleExtension on Locale {
  /// Converts the locale code into a human-readable language name.
  ///
  /// If [toOriginal] is true, it returns the original language name.
  ///
  /// If [toOriginal] is false, it returns the translated language name.
  ///
  /// Returns "Unknown" if the language code is not supported.
  ///
  /// ```dart
  /// // Creating a Locale object representing English language
  /// const englishLocale = Locale('en', 'US');
  ///
  /// // Calling the extension method to get the language name
  /// print(englishLocale.localeToLanguageName()); // Output: English
  ///
  /// // Calling the extension method with toOriginal set to false
  /// // to get the translated language name
  /// print(englishLocale.localeToLanguageName(toOriginal: false)); // Output: Inglés
  /// ```
  String localeToLanguageName({final bool toOriginal = true}) {
    final String type = toOriginal ? 'original' : 'translation';

    // Mapping of language codes to language names.
    final Map<String, String> languageMap = <String, String>{
      'en': 'core.languages.en.$type'.tr(),
      'es': 'core.languages.es.$type'.tr(),
      'pt': 'core.languages.pt.$type'.tr(),
    };

    // Fetches the language name corresponding to the language code.
    // Returns "Unknown" if the language code is not found in the map.
    return languageMap[languageCode] ?? 'Unknown';
  }
}
