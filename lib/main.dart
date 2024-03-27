import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'demoafgr.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'resources/langs',
      assetLoader: const CodegenLoader(),
      supportedLocales: supportedI18nLocals,
      fallbackLocale: supportedI18nLocals.first,
      child: MyApp(),
    ),
  );
}
