import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../pre_main.dart';

late BuildContext _context;

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.shortcutUrlBloc});
  final ShortcutUrlBloc shortcutUrlBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: EasyLocalization.of(context)!.locale,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      localizationsDelegates: EasyLocalization.of(context)!.delegates,
      home: MyWidget(shortcutUrlBloc: shortcutUrlBloc),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.shortcutUrlBloc});
  final ShortcutUrlBloc shortcutUrlBloc;

  @override
  Widget build(context) {
    _context = context;
    return ShortUrlScreen(shortcutUrlBloc: shortcutUrlBloc);
  }
}

void main() async {
  preMainTest();

  late MockShortcutUrlBloc mockBloc;
  late MockShortcutUrlRepository mockShortcutUrlRepository;

  setUp(() {
    mockBloc = MockShortcutUrlBloc();
    mockShortcutUrlRepository = MockShortcutUrlRepository();
  });

  testWidgets(
    'ShortUrlScreen builds correctly',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MockBase.appTest(MyApp(shortcutUrlBloc: mockBloc)),
        );

        await tester.pumpAndSettle();

        expect(find.byType(ShortUrlScreen), findsOneWidget);

        expect(_context.supportedLocales, supportedLocalsCurrent);
        expect(_context.locale, const Locale('en', 'US'));

        expect(find.text('Demo AFGR'), findsOneWidget);
        expect(find.text('https://'), findsOneWidget);
        expect(find.text('Recently shortend URLs'), findsOneWidget);
        expect(
          find.text('Looks a bit empty here! Add your first shortened URLs.'),
          findsOneWidget,
        );
      });
    },
  );
  testWidgets('Generates a short URL', (WidgetTester tester) async {
    await tester.runAsync(() async {
      when(() => mockBloc.generateShortcutUrl(any()))
          .thenAnswer((_) async => true);

      await tester.pumpWidget(
        EasyLocalization(
          path: 'resources/langs',
          assetLoader: const CodegenLoader(),
          supportedLocales: CdsI18n.supportedLocals,
          child: MyApp(shortcutUrlBloc: mockBloc),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'https://example.com');
      expect(find.text('https://example.com'), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => mockBloc.generateShortcutUrl('https://example.com'))
          .called(1);
    });
  });

  testWidgets('Empty URL Input Test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      when(() => mockBloc.generateShortcutUrl(any()))
          .thenAnswer((_) async => true);

      await tester.pumpWidget(
        EasyLocalization(
          path: 'resources/langs',
          assetLoader: const CodegenLoader(),
          supportedLocales: CdsI18n.supportedLocals,
          child: MyApp(shortcutUrlBloc: mockBloc),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Enter the URL'), findsOneWidget);
      verifyNever(() => mockBloc.generateShortcutUrl(any()));
    });
  });
  testWidgets('Error Handling', (WidgetTester tester) async {
    await tester.runAsync(() async {
      when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
        (_) async => FailureState(
          DataNetworkExceptionState(
            message: 'NetworkException.noInternetConnection',
            stackTrace: StackTrace.current,
          ),
        ),
      );

      await tester.pumpWidget(
        EasyLocalization(
          path: 'resources/langs',
          assetLoader: const CodegenLoader(),
          supportedLocales: CdsI18n.supportedLocals,
          child: MyApp(
            shortcutUrlBloc: ShortcutUrlBloc(
              shortcutUrlRepository: mockShortcutUrlRepository,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'https://example.com');
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text(
          'Error Network: No Internet connection. Check your network and retry.',
        ),
        findsOneWidget,
      );
    });
  });
  testWidgets('Updated UI for after success url generation',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
        (_) async => const SuccessState(
          ShortcutUrlModel(
            alias: '123456',
            links: LinksModel(
              self: 'http://example.com',
              short: 'http://short.link.com/123456',
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        EasyLocalization(
          path: 'resources/langs',
          assetLoader: const CodegenLoader(),
          supportedLocales: CdsI18n.supportedLocals,
          child: MyApp(
            shortcutUrlBloc: ShortcutUrlBloc(
              shortcutUrlRepository: mockShortcutUrlRepository,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsNWidgets(4));

      await tester.enterText(find.byType(TextField), 'https://example.com');
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsNWidgets(5));

      expect(find.byType(CdsItemListTileShortcutUrl), findsOneWidget);
      expect(find.text('http://example.com'), findsOneWidget);
      expect(find.text('http://short.link.com/123456'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'https://examples.com');
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
