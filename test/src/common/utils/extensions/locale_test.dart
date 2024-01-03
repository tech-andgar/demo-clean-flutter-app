import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:demoafgr/generated/locale_keys.g.dart';
import 'package:demoafgr/src/common/common.dart';
import 'package:demoafgr/src/core/i18n/i18n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

late BuildContext _context;
const supportedLocalsCurrent = [
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('pt', 'BR'),
];

class MyApp extends StatelessWidget {
  const MyApp({
    this.child = const MyWidget(),
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: child,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(context) {
    _context = context;
    const localeEn = Locale('en', 'US');
    const localeEs = Locale('es', 'ES');
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('core.languages.pt.original'.tr()),
          Text(localeEn.localeToLanguageName(false)),
          Text(localeEs.localeToLanguageName(true)),
        ],
      ),
    );
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  EasyLocalization.logger.enableLevels = <LevelMessages>[
    LevelMessages.error,
    LevelMessages.warning,
  ];
  await EasyLocalization.ensureInitialized();
  testWidgets(
    '[EasyLocalization with CodegenLoader] test',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          EasyLocalization(
            path: 'resources/langs',
            assetLoader: const CodegenLoader(),
            supportedLocales: CdsI18n.supportedLocals,
            child: const MyApp(),
          ),
        );
        // await tester.idle();
        // The async delegator load will require build on the next frame. Thus, pump
        await tester.pumpAndSettle();

        expect(_context.supportedLocales, supportedLocalsCurrent);
        expect(_context.locale, const Locale('en', 'US'));

        final trFinder = find.text('English');
        expect(trFinder, findsOneWidget);
        expect(tr('core.languages.en.original'), 'English');
        expect(tr('core.languages.es.original'), 'Español');
        expect(tr('core.languages.pt.original'), 'Portuguese');
      });
    },
  );

  testWidgets(
    '[EasyLocalization] change locale test',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          EasyLocalization(
            path: 'resources/langs',
            assetLoader: const CodegenLoader(),
            supportedLocales: CdsI18n.supportedLocals,
            child: const MyApp(),
          ),
        );

        await tester.pump();

        final trFinder = find.text('English');
        expect(trFinder, findsOneWidget);
        expect(Localization.of(_context), isInstanceOf<Localization>());
        expect(_context.supportedLocales, supportedLocalsCurrent);
        expect(_context.locale, const Locale('en', 'US'));
        expect(LocaleKeys.core_languages_en_translation.tr(), 'English');

        const changedLocaleEs = Locale('es', 'ES');
        await _context.setLocale(changedLocaleEs);
        await tester.pump();

        expect(_context.locale, changedLocaleEs);
        expect(tr(LocaleKeys.core_languages_en_translation), 'Inglés');

        const changedLocalePt = Locale('pt', 'BR');
        await _context.setLocale(changedLocalePt);
        await tester.pump();

        expect(_context.locale, changedLocalePt);
        expect(tr(LocaleKeys.core_languages_en_translation), 'Inglês');
      });
    },
  );
  testWidgets(
    'Extension locale test',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          EasyLocalization(
            path: 'resources/langs',
            assetLoader: const CodegenLoader(),
            supportedLocales: CdsI18n.supportedLocals,
            child: const MyApp(),
          ),
        );
        await tester.pump();
        const changedLocale = Locale('pt', 'BR');
        await _context.setLocale(changedLocale);
        await tester.pump();

        final trEnFinder = find.text('Inglês');
        expect(trEnFinder, findsOneWidget);
        final trEsFinder = find.text('Español');
        expect(trEsFinder, findsOneWidget);
      });
    },
  );
  test('Should return "Unknown" for unsupported locales', () {
    const localeUnsupported = Locale('fr');
    expect(localeUnsupported.localeToLanguageName(), 'Unknown');
  });
}
