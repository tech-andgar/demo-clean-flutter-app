import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/codegen_loader.g.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

///  Core

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

class MockConnectivity extends Mock implements Connectivity {}

class MockDioException extends Mock implements DioException {
  MockDioException({required this.type});

  @override
  DioExceptionType type;
}

class MockDioExceptionHandler extends Mock implements DioExceptionHandler {}

class MockApiHandler<R, T> extends Mock implements ApiHandler<R, T> {}

class MockHttpClient extends Mock implements HttpClient {}

class MockClient extends Mock implements http.Client {}

class MockStreamedResponse extends Mock implements http.StreamedResponse {}

class MockBaseRequest extends Mock implements BaseRequest {}

class FakeApiHandler extends Fake
    implements ApiHandler<dio.Response<dynamic>, ShortcutUrlModel?> {}

/// Model - DataSource

class MockShortcutUrlModel extends Mock implements ShortcutUrlModel {}

class MockShortcutUrlRepository extends Mock implements ShortcutUrlRepository {}

class MockShortcutUrlRemoteDataSource extends Mock
    implements ShortcutUrlRemoteDataSource {}

/// UI

class MockLocale extends Mock implements Locale {}

class MockBuildContext extends Mock implements BuildContext {}

class MockClipboard {
  static String? _copiedText;

  static Future<void> setData(ClipboardData data) async {
    _copiedText = data.text;
  }

  static Future<ClipboardData> getData(String format) async {
    return ClipboardData(text: _copiedText ?? '');
  }
}

/// BLoC

class MockShortcutUrlBloc extends Mock implements ShortcutUrlBloc {
  @override
  ValueNotifier<NotificationMessage?> get notifierNotificationMessage =>
      ValueNotifier<NotificationMessage?>(null);
  @override
  final notifierItemsShortcutUrls = ValueNotifier<List<ShortcutUrlModel>>([]);
  @override
  List<ShortcutUrlModel> get itemsShortcutUrls =>
      notifierItemsShortcutUrls.value;

  @override
  final notifierLoading = ValueNotifier<bool>(false);

  @override
  bool get isLoading => notifierLoading.value;
}

const supportedLocalsCurrent = [
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('pt', 'BR'),
];

class MockBase {
  static Widget appTest([Widget? widget]) {
    return EasyLocalization(
      path: 'resources/langs',
      assetLoader: const CodegenLoader(),
      supportedLocales: CdsI18n.supportedLocals,
      child: _AppTest(widget: widget),
    );
  }
}

class _AppTest extends StatelessWidget {
  const _AppTest({this.widget});

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
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
  void dispose() {
    theme_ = null;
    context_ = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme_ = context.theme;
    context_ = context;
    return Scaffold(body: widget.child);
  }
}
