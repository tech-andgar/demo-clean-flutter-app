import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import '../../../pre_main.dart';

void main() async {
  await preMainTest();
  tearDown(() => context_ = null);
  testWidgets(
    '[EasyLocalization with CodegenLoader] test',
    (final WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MockBase.appTest(const MyWidgetLanguages()));
        await tester.pumpAndSettle();

        expect(context_!.supportedLocales, supportedLocalsCurrent);
        expect(context_!.locale, const Locale('en', 'US'));

        final Finder trFinder = find.text('English');
        expect(trFinder, findsOneWidget);
        expect(tr('core.languages.en.original'), 'English');
        expect(tr('core.languages.es.original'), 'Español');
        expect(tr('core.languages.pt.original'), 'Portuguese');
      });
    },
  );

  testWidgets(
    '[EasyLocalization] change locale test',
    (final WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MockBase.appTest(const MyWidgetLanguages()));
        await tester.pumpAndSettle();

        final Finder trFinder = find.text('English');
        expect(trFinder, findsOneWidget);
        expect(Localization.of(context_!), isInstanceOf<Localization>());
        expect(context_!.supportedLocales, supportedLocalsCurrent);
        expect(context_!.locale, const Locale('en', 'US'));
        expect(LocaleKeys.core_languages_en_translation.tr(), 'English');

        const Locale changedLocaleEs = Locale('es', 'ES');
        await context_!.setLocale(changedLocaleEs);
        await tester.pump();

        expect(context_!.locale, changedLocaleEs);
        expect(tr(LocaleKeys.core_languages_en_translation), 'Inglés');

        const Locale changedLocalePt = Locale('pt', 'BR');
        await context_!.setLocale(changedLocalePt);
        await tester.pump();

        expect(context_!.locale, changedLocalePt);
        expect(tr(LocaleKeys.core_languages_en_translation), 'Inglês');
      });
    },
  );
  testWidgets(
    'Extension locale test',
    (final WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MockBase.appTest(const MyWidgetLanguages()));
        await tester.pumpAndSettle();

        const Locale changedLocale = Locale('pt', 'BR');
        await context_!.setLocale(changedLocale);
        await tester.pump();

        final Finder trEnFinder = find.text('Inglês');
        expect(trEnFinder, findsOneWidget);
        final Finder trEsFinder = find.text('Español');
        expect(trEsFinder, findsOneWidget);
      });
    },
  );
  test('Should return "Unknown" for unsupported locales', () {
    const Locale localeUnsupported = Locale('fr');
    expect(localeUnsupported.localeToLanguageName(), 'Unknown');
  });
}
