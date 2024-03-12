import 'package:demoafgr/demoafgr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  EasyLocalization.logger.enableLevels = <LevelMessages>[];
  late ShortcutUrlBloc shortcutUrlBloc;
  late MockShortcutUrlRepository mockShortcutUrlRepository;

  setUp(() {
    mockShortcutUrlRepository = MockShortcutUrlRepository();
    shortcutUrlBloc =
        ShortcutUrlBloc(shortcutUrlRepository: mockShortcutUrlRepository);
  });

  tearDown(() {
    shortcutUrlBloc.dispose();
  });

  test('should handle invalid URL input', () async {
    const testUrl = 'invalid-url';

    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
  });

  test('should handle duplicate URL input', () async {
    const testUrl = 'http://test.com';
    shortcutUrlBloc.notifierItemsShortcutUrls.value = [
      const ShortcutUrlModel(
        alias: '123456',
        links: LinksModel(
          self: 'http://test.com',
          short: 'http://short.link.com/123456',
        ),
      ),
    ];

    expect(await shortcutUrlBloc.generateShortcutUrl(testUrl), false);
  });

  test('should handle successful URL generation', () async {
    const testUrl = 'http://test.com';
    expect(shortcutUrlBloc.isLoading, false);
    expect(shortcutUrlBloc.itemsShortcutUrls.length, 0);

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => const SuccessState(
        ShortcutUrlModel(
          alias: '123456',
          links: LinksModel(
            self: 'http://test.com',
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataNetworkExceptionState(
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataClientExceptionState(
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataParseExceptionState(
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataParseExceptionState(
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataHttpExceptionState(
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
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRepository.postShortcutUrl(any())).thenAnswer(
      (_) async => FailureState(
        DataCacheExceptionState(
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
