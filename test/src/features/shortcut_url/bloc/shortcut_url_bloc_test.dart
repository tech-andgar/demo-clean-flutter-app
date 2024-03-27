import 'package:demoafgr/demoafgr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_exception/http_exception.dart';
import 'package:http_status/http_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  EasyLocalization.logger.enableLevels = <LevelMessages>[];
  late ShortcutUrlBloc shortcutUrlBloc;
  late MockShortcutUrlRepository mockShortcutUrlRepository;
  const String testUrl = 'http://test.com';

  setUp(() {
    mockShortcutUrlRepository = MockShortcutUrlRepository();
    shortcutUrlBloc =
        ShortcutUrlBloc(shortcutUrlRepository: mockShortcutUrlRepository);
  });

  tearDown(() {
    shortcutUrlBloc.dispose();
  });

  test('should handle invalid URL input', () async {
    const String testUrl = 'invalid-url';

    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
  });

  test('should handle duplicate URL input', () async {
    shortcutUrlBloc.notifierItemsShortcutUrls.value = <ShortcutUrlModel>[
      const ShortcutUrlModel(
        alias: '123456',
        links: LinksModel(
          self: testUrl,
          short: 'http://short.link.com/123456',
        ),
      ),
    ];

    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
  });

  test('should handle successful URL generation', () async {
    expect(shortcutUrlBloc.isLoading, false);
    expect(shortcutUrlBloc.itemsShortcutUrls.length, 0);

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => const SuccessState<ShortcutUrlModel?>(
        ShortcutUrlModel(
          alias: '123456',
          links: LinksModel(
            self: testUrl,
            short: 'http://short.link.com/123456',
          ),
        ),
      ),
    );

    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), true);
    expect(shortcutUrlBloc.itemsShortcutUrls.length, 1);
    expect(shortcutUrlBloc.isLoading, false);
  });

  test('should handle failure DataNetworkException in URL generation',
      () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataNetworkExceptionState<ShortcutUrlModel?>(
          message: 'NetworkException.noInternetConnection',
          stackTrace: StackTrace.current,
        ),
      ),
    );
    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error Network: core.exception.networkNoInternetConnection',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
  test('should handle failure DataClientException in URL generation', () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataClientExceptionState<ShortcutUrlModel?>(
          message: 'Falied.ExceptionInternalClient',
          stackTrace: StackTrace.current,
        ),
      ),
    );
    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error Client: ExceptionInternalClient',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
  test('should handle failure DataParseException in URL generation', () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataParseExceptionState<ShortcutUrlModel?>(
          message: 'Falied.ExceptionInternalParse',
          stackTrace: StackTrace.current,
        ),
      ),
    );
    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error Data Parse: Falied.ExceptionInternalParse',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
  test('should handle failure DataParseException in URL generation', () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataParseExceptionState<ShortcutUrlModel?>(
          message: 'Falied.ExceptionInternalParse',
          stackTrace: StackTrace.current,
        ),
      ),
    );

    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error Data Parse: Falied.ExceptionInternalParse',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
  test('should handle failure DataParseException in URL generation', () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataHttpExceptionState<ShortcutUrlModel?>(
          message: 'Falied.ExceptionInternalHttp',
          httpException: HttpStatus.fromCode(404).exception(),
          stackTrace: StackTrace.current,
        ),
      ),
    );

    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error HTTP 404: core.httpCode.404',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
  test(
      'should handle failure ExeptionState other type Unknown in URL generation',
      () async {
    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (final _) async => FailureState<ShortcutUrlModel?>(
        DataCacheExceptionState<ShortcutUrlModel?>(
          message: 'CacheException.unknown',
          stackTrace: StackTrace.current,
        ),
      ),
    );

    expect(shortcutUrlBloc.isLoading, false);
    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.type,
      NotificationType.error,
    );
    expect(
      shortcutUrlBloc.notifierNotificationMessage.value?.message,
      'Error Unknown: DataCacheExceptionState<ShortcutUrlModel?>(cacheException: "CacheException.unknown")',
    );
    expect(shortcutUrlBloc.isLoading, false);
  });
}
