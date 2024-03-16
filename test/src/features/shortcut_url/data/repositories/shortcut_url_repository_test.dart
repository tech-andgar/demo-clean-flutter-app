import 'package:demoafgr/demoafgr.dart';
import 'package:dio/dio.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late ShortcutUrlRepository repository;
  late MockDioExceptionHandler mockExceptionHandler;
  late MockShortcutUrlRemoteDataSource mockDataSource;

  setUp(() {
    registerFallbackValue(FakeApiHandler());

    mockExceptionHandler = MockDioExceptionHandler();
    mockDataSource = MockShortcutUrlRemoteDataSource();

    repository = ShortcutUrlRepository(
      clientExceptionHandler: mockExceptionHandler,
      dataSource: mockDataSource,
    );
  });

  group('ShortcutUrlRepository', () {
    test('postShortcutUrl returns SuccessState on successful API call',
        () async {
      const url = 'https://example.com';
      const shortcutUrlModel = ShortcutUrlModel(
        alias: 'example',
        links: LinksModel(self: '', short: ''),
      );

      when(() => mockDataSource.newShortcutUrl(url)).thenAnswer(
        (_) async => Response(
          data: '/* ... */',
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );
      when(
        () => mockExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
      ).thenAnswer((_) async => const SuccessState(shortcutUrlModel));

      final result = await repository.postShortcutUrl(url);

      expect(result, isA<SuccessState>());
      expect((result as SuccessState).data, shortcutUrlModel);
    });
    test('postShortcutUrl returns FailureState on network exception', () async {
      const url = 'https://example.com';
      final stackTrace = StackTrace.current;

      when(() => mockDataSource.newShortcutUrl(url))
          .thenThrow(NetworkException.noInternetConnection);
      when(
        () => mockExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
      ).thenAnswer(
        (_) async => FailureState(
          DataNetworkExceptionState(
            message: 'NetworkException.noInternetConnection',
            stackTrace: stackTrace,
          ),
        ),
      );

      final result = await repository.postShortcutUrl(url);

      expect(result, isA<FailureState>());
      expect(
        (result as FailureState).exception,
        isA<DataNetworkExceptionState>(),
      );
    });
    test('postShortcutUrl returns FailureState on DioException', () async {
      const url = 'https://example.com';
      final stackTrace = StackTrace.current;
      final dioException =
          DioException(requestOptions: RequestOptions(path: url));

      when(() => mockDataSource.newShortcutUrl(url)).thenThrow(dioException);
      when(
        () => mockExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
      ).thenAnswer(
        (_) async => FailureState(
          DataClientExceptionState(
            message: dioException.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );

      final result = await repository.postShortcutUrl(url);

      expect(result, isA<FailureState>());
      expect(
        (result as FailureState).exception,
        isA<DataClientExceptionState>(),
      );
    });
    test('postShortcutUrl returns FailureState on parse error', () async {
      const url = 'https://example.com';
      final stackTrace = StackTrace.current;
      const parseException = FormatException('Invalid JSON');

      when(() => mockDataSource.newShortcutUrl(url)).thenAnswer(
        (_) async => Response(
          data: 'invalid json',
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );
      when(
        () => mockExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
      ).thenAnswer(
        (_) async => FailureState(
          DataParseExceptionState(
            message: parseException.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );

      final result = await repository.postShortcutUrl(url);

      expect(result, isA<FailureState>());
      expect(
        (result as FailureState).exception,
        isA<DataParseExceptionState>(),
      );
    });

    test('parserModel parses non-null result correctly', () async {
      const url = 'https://example.com';
      final mockResponseData = {
        'alias': '1878290138',
        '_links': {
          'self': 'www.example.com',
          'short':
              'https://url-shortener-server.onrender.com/api/alias/1878290138',
        },
      };

      when(() => mockDataSource.newShortcutUrl(url)).thenAnswer(
        (_) async => Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      when(
        () => mockExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
      ).thenAnswer(
        (_) async => SuccessState(ShortcutUrlModel.fromJson(mockResponseData)),
      );

      final result = await repository.postShortcutUrl(url);

      expect(result, isA<SuccessState<ShortcutUrlModel?>>());
      final successResult = result as SuccessState<ShortcutUrlModel?>;
      expect(successResult.data, isNotNull);
      expect(successResult.data?.alias, equals('1878290138'));
    });
  });
}
