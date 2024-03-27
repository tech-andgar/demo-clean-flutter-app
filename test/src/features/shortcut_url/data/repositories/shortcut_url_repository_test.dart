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

  group(
    'ShortcutUrlRepository',
    () {
      test(
        'postShortcutUrl returns SuccessState on successful API call',
        () async {
          const String url = 'https://example.com';
          const ShortcutUrlModel shortcutUrlModel = ShortcutUrlModel(
            alias: 'example',
            links: LinksModel(self: '', short: ''),
          );

          when(() => mockDataSource.newShortcutUrl(url)).thenAnswer(
            (final _) async => Response<Object?>(
              data: '/* ... */',
              statusCode: 200,
              requestOptions: RequestOptions(),
            ),
          );
          when(
            () => mockExceptionHandler
                .callApi<Response<Object?>, ShortcutUrlModel?>(any()),
          ).thenAnswer(
            (final _) async =>
                const SuccessState<ShortcutUrlModel?>(shortcutUrlModel),
          );

          final ResultState<ShortcutUrlModel?> result =
              await repository.postShortcutUrl(url);

          expect(result, isA<SuccessState<ShortcutUrlModel?>>());
          expect(
            (result as SuccessState<ShortcutUrlModel?>).data,
            shortcutUrlModel,
          );
        },
      );
      test(
        'postShortcutUrl returns FailureState on network exception',
        () async {
          const String url = 'https://example.com';
          final StackTrace stackTrace = StackTrace.current;

          when(
            () => mockExceptionHandler
                .callApi<Response<Object?>, ShortcutUrlModel?>(any()),
          ).thenAnswer(
            (final _) async => FailureState<ShortcutUrlModel?>(
              DataNetworkExceptionState<ShortcutUrlModel?>(
                message: 'NetworkException.noInternetConnection',
                stackTrace: stackTrace,
              ),
            ),
          );

          final ResultState<ShortcutUrlModel?> result =
              await repository.postShortcutUrl(url);

          expect(result, isA<FailureState<ShortcutUrlModel?>>());
          expect(
            (result as FailureState<ShortcutUrlModel?>).exception,
            isA<DataNetworkExceptionState<ShortcutUrlModel?>>(),
          );
        },
      );
      test(
        'postShortcutUrl returns FailureState on DioException',
        () async {
          const String url = 'https://example.com';
          final StackTrace stackTrace = StackTrace.current;
          final DioException dioException =
              DioException(requestOptions: RequestOptions(path: url));

          when(() => mockDataSource.newShortcutUrl(url))
              .thenThrow(dioException);
          when(
            () => mockExceptionHandler
                .callApi<Response<Object?>, ShortcutUrlModel?>(any()),
          ).thenAnswer(
            (final _) async => FailureState<ShortcutUrlModel?>(
              DataClientExceptionState<ShortcutUrlModel?>(
                message: dioException.toString(),
                stackTrace: stackTrace,
              ),
            ),
          );

          final ResultState<ShortcutUrlModel?> result =
              await repository.postShortcutUrl(url);

          expect(result, isA<FailureState<ShortcutUrlModel?>>());
          expect(
            (result as FailureState<ShortcutUrlModel?>).exception,
            isA<DataClientExceptionState<ShortcutUrlModel?>>(),
          );
        },
      );
      test(
        'postShortcutUrl returns FailureState on parse error',
        () async {
          const String url = 'https://example.com';
          final StackTrace stackTrace = StackTrace.current;
          const FormatException parseException =
              FormatException('Invalid JSON');

          when(
            () => mockExceptionHandler
                .callApi<Response<Object?>, ShortcutUrlModel?>(any()),
          ).thenAnswer(
            (final _) async => FailureState<ShortcutUrlModel?>(
              DataParseExceptionState<ShortcutUrlModel?>(
                message: parseException.toString(),
                stackTrace: stackTrace,
              ),
            ),
          );

          final ResultState<ShortcutUrlModel?> result =
              await repository.postShortcutUrl(url);

          expect(result, isA<FailureState<ShortcutUrlModel?>>());
          expect(
            (result as FailureState<ShortcutUrlModel?>).exception,
            isA<DataParseExceptionState<ShortcutUrlModel?>>(),
          );
        },
      );

      test(
        'parserModel parses non-null result correctly',
        () async {
          const String url = 'https://example.com';
          final Map<String, Object> mockResponseData = <String, Object>{
            'alias': '1878290138',
            '_links': <String, String>{
              'self': 'www.example.com',
              'short':
                  'https://url-shortener-server.onrender.com/api/alias/1878290138',
            },
          };

          when(() => mockDataSource.newShortcutUrl(url)).thenAnswer(
            (final _) async => Response<Object?>(
              data: mockResponseData,
              statusCode: 200,
              requestOptions: RequestOptions(),
            ),
          );

          when(
            () => mockExceptionHandler
                .callApi<Response<Object?>, ShortcutUrlModel?>(any()),
          ).thenAnswer(
            (final _) async => SuccessState<ShortcutUrlModel?>(
              ShortcutUrlModel.fromJson(mockResponseData),
            ),
          );

          final ResultState<ShortcutUrlModel?> result =
              await repository.postShortcutUrl(url);

          expect(result, isA<SuccessState<ShortcutUrlModel?>>());
          final SuccessState<ShortcutUrlModel?> successResult =
              result as SuccessState<ShortcutUrlModel?>;
          expect(successResult.data, isNotNull);
          expect(successResult.data?.alias, equals('1878290138'));
        },
      );
    },
  );
}
