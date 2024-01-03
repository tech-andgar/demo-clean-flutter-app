import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../pre_main.dart';

void main() async {
  preMainTest();
  group('CdsChangeLanguage Widget Tests', () {
    tearDown(() {
      context_ = null;
    });
    testWidgets('Renders PopupMenuButton with correct items',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockBase.appTest(CdsChangeLanguage(() {})));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuButton), findsOneWidget);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pump();

      expect(find.byType(PopupMenuItem), findsNWidgets(3));
    });
    testWidgets('Renders PopupMenuButton with correct items and handles taps',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockBase.appTest(CdsChangeLanguage(() {})));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuButton), findsOneWidget);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();

      expect(
        find.byType(PopupMenuItem),
        findsNWidgets(CdsI18n.supportedLocals.length),
      );

      await tester.tap(
        find.text('English').last,
      );
      await tester.pump();
    });
    testWidgets('Locale verify correctly in en-US',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockBase.appTest(CdsChangeLanguage(() {})));
      await tester.pumpAndSettle();

      final BuildContext context =
          tester.element(find.byType(CdsChangeLanguage));
      expect(Localizations.localeOf(context), equals(const Locale('en', 'US')));
    });

    testWidgets('setState callback is invoked on selection',
        (WidgetTester tester) async {
      bool callbackInvoked = false;
      mockCallback() => callbackInvoked = true;

      await tester
          .pumpWidget(MockBase.appTest(CdsChangeLanguage(mockCallback)));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuButton), findsOneWidget);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();

      expect(
        find.byType(PopupMenuItem),
        findsNWidgets(CdsI18n.supportedLocals.length),
      );

      await tester.tap(find.text('Portuguese').last);
      await tester.pumpAndSettle();

      expect(callbackInvoked, isTrue);
    });
  });
  group('UI/UX Tests for CdsChangeLanguage', () {
    testWidgets('UI elements display correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EasyLocalization(
              supportedLocales: CdsI18n.supportedLocals,
              path: 'resources/langs',
              assetLoader: const CodegenLoader(),
              child: CdsChangeLanguage(() {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.language), findsOneWidget);

      final Finder languageButton = find.byType(PopupMenuButton);
      expect(
        tester.widget<PopupMenuButton>(languageButton).tooltip,
        'Change language',
      );
    });
  });
}
