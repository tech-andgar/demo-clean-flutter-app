import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
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
      supportedLocales: CdsI18n.supportedLocals,
      fallbackLocale: CdsI18n.supportedLocals.first,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: ShortUrlScreen(
        shortcutUrlBloc: ShortcutUrlBloc(
          shortcutUrlRepository: ShortcutUrlRepository(
            clientExceptionHandler: DioExceptionHandler(),
            dataSource: ShortcutUrlRemoteDataSource(),
          ),
        ),
      ),
    );
  }
}
