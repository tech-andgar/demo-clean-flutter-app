import 'package:demoafgr/demoafgr.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('ShortcutUrlRemoteDataSource Tests', () {
    late ShortcutUrlRemoteDataSource dataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = ShortcutUrlRemoteDataSource(mockHttpClient);
    });

    test('newShortcutUrl should make a POST request and return a response',
        () async {
      const String testUrl = 'https://example.com';
      final Response<String> expectedResponse = Response<String>(
        requestOptions: RequestOptions(path: 'alias'),
        data: 'some data',
        statusCode: 200,
      );

      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((final _) async => expectedResponse);

      final Response<Object?> response =
          await dataSource.newShortcutUrl(testUrl);

      expect(response, expectedResponse);
      verify(() => mockHttpClient.post('alias', body: any(named: 'body')))
          .called(1);
    });

    test('newShortcutUrl should handle network errors gracefully', () async {
      const String testUrl = 'https://example.com';

      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'alias'),
          error: 'Network Error',
        ),
      );

      expect(
        () async => await dataSource.newShortcutUrl(testUrl),
        throwsA(isA<DioException>()),
      );
    });

    test('newShortcutUrl should handle non-200 status codes', () async {
      const String testUrl = 'https://example.com';
      final Response<String> errorResponse = Response<String>(
        requestOptions: RequestOptions(path: 'alias'),
        data: 'Error occurred',
        statusCode: 404,
      );

      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((final _) async => errorResponse);

      final Response<Object?> response =
          await dataSource.newShortcutUrl(testUrl);

      expect(response.statusCode, 404);
      expect(response.data, 'Error occurred');
    });
  });
}
