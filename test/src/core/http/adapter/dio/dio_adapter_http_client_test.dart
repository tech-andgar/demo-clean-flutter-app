import 'package:demoafgr/demoafgr.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('DioAdapterHttpClient Tests', () {
    late DioAdapterHttpClient client;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      client = DioAdapterHttpClient('https://example.com', dio: mockDio);

      mockDio.options.baseUrl = 'https://example.com';

      when(
        () => mockDio.get<Object?>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'GET response',
        ),
      );
    });

    test('Sends GET request correctly', () async {
      final Response<Object?> response = await client.get('endpoint');
      expect(response.data, 'GET response');
      verify(
        () => mockDio.get<Object?>(
          'endpoint',
          queryParameters: null,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends POST request correctly', () async {
      final dynamic postData = <String, String>{'key': 'value'};
      when(
        () => mockDio.post<Object?>(
          any(),
          data: postData,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'POST response',
        ),
      );

      final Response<Object?> response =
          await client.post('endpoint', body: postData);
      expect(response.data, 'POST response');
      verify(
        () => mockDio.post<Object?>(
          'endpoint',
          data: postData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends PUT request correctly', () async {
      final dynamic putData = <String, String>{'key': 'value'};
      when(
        () => mockDio.put<Object?>(
          any(),
          data: putData,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'PUT response',
        ),
      );

      final Response<Object?> response =
          await client.put('endpoint', body: putData);
      expect(response.data, 'PUT response');
      verify(
        () => mockDio.put<Object?>(
          'endpoint',
          data: putData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends DELETE request correctly', () async {
      when(() => mockDio.delete<Object?>(any(), options: any(named: 'options')))
          .thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'DELETE response',
        ),
      );

      final Response<Object?> response = await client.delete('endpoint');
      expect(response.data, 'DELETE response');
      verify(
        () => mockDio.delete<Object?>(
          'endpoint',
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends PATCH request correctly', () async {
      final dynamic patchData = <String, String>{'key': 'value'};
      when(
        () => mockDio.patch<Object?>(
          any(),
          data: patchData,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'PATCH response',
        ),
      );

      final Response<Object?> response =
          await client.patch('endpoint', body: patchData);
      expect(response.data, 'PATCH response');
      verify(
        () => mockDio.patch<Object?>(
          'endpoint',
          data: patchData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });
    test('Sends HEAD request correctly', () async {
      when(() => mockDio.head<Object?>(any(), options: any(named: 'options')))
          .thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'HEAD response',
        ),
      );

      final Response<Object?> response = await client.head('endpoint');
      expect(response.data, 'HEAD response');
      verify(
        () => mockDio.head<Object?>('endpoint', options: any(named: 'options')),
      ).called(1);
    });

    test('Sends request using generic method correctly', () async {
      when(
        () => mockDio.request<Object?>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (final _) async => Response<Object?>(
          requestOptions: RequestOptions(path: ''),
          data: 'Generic response',
        ),
      );

      final Response<Object?> response =
          await client.request('endpoint', method: HTTPRequestMethod.get);
      expect(response.data, 'Generic response');
      verify(
        () => mockDio.request<Object?>(
          'endpoint',
          queryParameters: null,
          options: any(named: 'options'),
          data: null,
        ),
      ).called(1);
    });

    test('Handles errors correctly', () async {
      when(() => mockDio.get<Object?>(any(), options: any(named: 'options')))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Error occurred',
        ),
      );

      expect(
        () async => await client.get('endpoint'),
        throwsA(isA<DioException>()),
      );
    });
    test('Updates the base URL correctly', () {
      const String newBaseUrl = 'https://newexample.com';
      client.updateBaseUrl(newBaseUrl);

      expect(mockDio.options.baseUrl, newBaseUrl);
    });
  });
}
