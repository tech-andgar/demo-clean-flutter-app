import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

///  Core.

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

class MockDioExceptionHandler extends Mock implements DioExceptionHandler {}

class MockHttpClient extends Mock implements HttpClient {}

class FakeApiHandler extends Fake
    implements ApiHandler<dio.Response<Object>, ShortcutUrlModel?> {}

/// Model - DataSource.

class MockShortcutUrlRepository extends Mock implements ShortcutUrlRepository {}

class MockShortcutUrlRemoteDataSource extends Mock
    implements ShortcutUrlRemoteDataSource {}

class MockClipboard {
  MockClipboard._();

  static String? _copiedText;

  static Future<ClipboardData> getData(final String _) async =>
      ClipboardData(text: _copiedText ?? '');

  static Future<void> setData(final ClipboardData data) async {
    await Future.value(null);
    _copiedText = data.text;
  }
}

/// BLoC.

class MockShortcutUrlBloc extends Mock implements ShortcutUrlBloc {
  @override
  final ValueNotifier<List<ShortcutUrlModel>> notifierItemsShortcutUrls =
      ValueNotifier<List<ShortcutUrlModel>>(<ShortcutUrlModel>[]);

  @override
  final ValueNotifier<bool> notifierLoading = ValueNotifier<bool>(false);

  @override
  bool get isEmptyData => notifierItemsShortcutUrls.value.isEmpty && !isLoading;

  @override
  bool get isLoading => notifierLoading.value;

  @override
  List<ShortcutUrlModel> get itemsShortcutUrls =>
      notifierItemsShortcutUrls.value;

  @override
  ValueNotifier<NotificationMessage?> get notifierNotificationMessage =>
      ValueNotifier<NotificationMessage?>(null);
}

const List<Locale> supportedLocalsCurrent = <Locale>[
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('pt', 'BR'),
];

class MockBase {
  MockBase._();

  static Widget appTest([final Widget? widget]) => EasyLocalization(
        path: 'resources/langs',
        assetLoader: const CodegenLoader(),
        supportedLocales: supportedI18nLocals,
        child: _AppTest(widget: widget),
      );
}

class _AppTest extends StatelessWidget {
  const _AppTest({this.widget});

  final Widget? widget;

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: DemoWidget(child: widget),
    );
  }
}

late BuildContext? context_;
late ThemeData? theme_;

class DemoWidget extends StatefulWidget {
  const DemoWidget({super.key, this.child});

  final Widget? child;

  @override
  State<DemoWidget> createState() => _DemoWidgetState();
}

class _DemoWidgetState extends State<DemoWidget> {
  @override
  Widget build(final BuildContext context) {
    theme_ = context.theme;
    context_ = context;

    return Scaffold(body: widget.child);
  }

  @override
  void dispose() {
    theme_ = null;
    context_ = null;
    super.dispose();
  }
}

class MyWidgetLanguages extends StatefulWidget {
  const MyWidgetLanguages({super.key});

  @override
  State<MyWidgetLanguages> createState() => _MyWidgetLanguagesState();
}

class _MyWidgetLanguagesState extends State<MyWidgetLanguages> {
  @override
  Widget build(final BuildContext context) {
    context_ = context;
    const localeEn = Locale('en', 'US');
    const localeEs = Locale('es', 'ES');

    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('core.languages.pt.original'.tr()),
          Text(localeEn.localeToLanguageName(toOriginal: false)),
          Text(localeEs.localeToLanguageName(toOriginal: true)),
        ],
      ),
    );
  }
}
