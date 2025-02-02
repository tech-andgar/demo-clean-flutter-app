import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../pre_main.dart';

void main() async {
  await preMainTest();
  group(
    'CdsChangeLanguage Widget Tests',
    () {
      tearDown(
        () {
          context_ = null;
        },
      );
      testWidgets(
        'Renders PopupMenuButton with correct items',
        (final tester) async {
          await tester.pumpWidget(MockBase.appTest(const CdsChangeLanguage()));
          await tester.pumpAndSettle();

          expect(find.byType(PopupMenuButton<Widget>), findsOneWidget);

          await tester.tap(find.byType(PopupMenuButton<Widget>));
          await tester.pump();

          expect(find.byType(PopupMenuItem<Widget>), findsNWidgets(3));
        },
      );
      testWidgets(
        'Renders PopupMenuButton with correct items and handles taps',
        (final tester) async {
          await tester.pumpWidget(MockBase.appTest(const CdsChangeLanguage()));
          await tester.pumpAndSettle();

          expect(find.byType(PopupMenuButton<Widget>), findsOneWidget);

          await tester.tap(find.byType(PopupMenuButton<Widget>));
          await tester.pumpAndSettle();

          expect(
            find.byType(PopupMenuItem<Widget>),
            findsNWidgets(supportedI18nLocals.length),
          );

          await tester.tap(
            find.text('English').last,
          );
          await tester.pump();
        },
      );
      testWidgets(
        'Locale verify correctly in en-US',
        (final tester) async {
          await tester.pumpWidget(MockBase.appTest(const CdsChangeLanguage()));
          await tester.pumpAndSettle();

          final BuildContext context =
              tester.element(find.byType(CdsChangeLanguage));
          expect(
            Localizations.localeOf(context),
            equals(const Locale('en', 'US')),
          );
        },
      );

      testWidgets(
        'setState callback is invoked on selection',
        (final tester) async {
          await tester.pumpWidget(MockBase.appTest(const CdsChangeLanguage()));
          await tester.pumpAndSettle();

          expect(find.byType(PopupMenuButton<Widget>), findsOneWidget);

          await tester.tap(find.byType(PopupMenuButton<Widget>));
          await tester.pumpAndSettle();

          expect(
            find.byType(PopupMenuItem<Widget>),
            findsNWidgets(supportedI18nLocals.length),
          );

          await tester.tap(find.text('Portuguese').last);
          await tester.pumpAndSettle();
        },
      );
    },
  );
  group(
    'UI/UX Tests for CdsChangeLanguage',
    () {
      testWidgets(
        'UI elements display correctly',
        (final tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: EasyLocalization(
                  supportedLocales: supportedI18nLocals,
                  path: 'resources/langs',
                  assetLoader: const CodegenLoader(),
                  child: const CdsChangeLanguage(),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.language), findsOneWidget);

          final languageButton = find.byType(PopupMenuButton<Widget>);
          expect(
            // ignore: strict_raw_type
            tester.widget<PopupMenuButton>(languageButton).tooltip,
            'Change language',
          );
        },
      );
    },
  );
}
