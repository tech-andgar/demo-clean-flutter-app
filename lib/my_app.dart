import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';

import 'demoafgr.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ShortcutUrlBloc shortcutUrlBloc = ShortcutUrlBloc(
    shortcutUrlRepository: ShortcutUrlRepository(
      clientExceptionHandler: DioExceptionHandler(),
      dataSource: ShortcutUrlRemoteDataSource(),
    ),
  );

  @override
  Widget build(final BuildContext context) {
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
      home: ShortcutUrlScreen(shortcutUrlBloc: shortcutUrlBloc),
    );
  }
}
