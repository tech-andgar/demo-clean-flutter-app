import 'package:demoafgr/src/core/core.dart';
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
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'GET response',
        ),
      );
    });

    test('Sends GET request correctly', () async {
      final response = await client.get('endpoint');
      expect(response.data, 'GET response');
      verify(
        () => mockDio.get(
          'endpoint',
          queryParameters: null,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends POST request correctly', () async {
      final dynamic postData = {'key': 'value'};
      when(
        () => mockDio.post(
          any(),
          data: postData,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'POST response',
        ),
      );

      final response = await client.post('endpoint', body: postData);
      expect(response.data, 'POST response');
      verify(
        () => mockDio.post(
          'endpoint',
          data: postData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends PUT request correctly', () async {
      final dynamic putData = {'key': 'value'};
      when(
        () => mockDio.put(any(), data: putData, options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'PUT response',
        ),
      );

      final response = await client.put('endpoint', body: putData);
      expect(response.data, 'PUT response');
      verify(
        () => mockDio.put(
          'endpoint',
          data: putData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Sends DELETE request correctly', () async {
      when(() => mockDio.delete(any(), options: any(named: 'options')))
          .thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'DELETE response',
        ),
      );

      final response = await client.delete('endpoint');
      expect(response.data, 'DELETE response');
      verify(() => mockDio.delete('endpoint', options: any(named: 'options')))
          .called(1);
    });

    test('Sends PATCH request correctly', () async {
      final dynamic patchData = {'key': 'value'};
      when(
        () => mockDio.patch(
          any(),
          data: patchData,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'PATCH response',
        ),
      );

      final response = await client.patch('endpoint', body: patchData);
      expect(response.data, 'PATCH response');
      verify(
        () => mockDio.patch(
          'endpoint',
          data: patchData,
          options: any(named: 'options'),
        ),
      ).called(1);
    });
    test('Sends HEAD request correctly', () async {
      when(() => mockDio.head(any(), options: any(named: 'options')))
          .thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'HEAD response',
        ),
      );

      final response = await client.head('endpoint');
      expect(response.data, 'HEAD response');
      verify(() => mockDio.head('endpoint', options: any(named: 'options')))
          .called(1);
    });

    test('Sends request using generic method correctly', () async {
      when(
        () => mockDio.request(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'Generic response',
        ),
      );

      final response =
          await client.request('endpoint', method: HTTPRequestMethod.get);
      expect(response.data, 'Generic response');
      verify(
        () => mockDio.request(
          'endpoint',
          queryParameters: null,
          options: any(named: 'options'),
          data: null,
        ),
      ).called(1);
    });

    test('Handles errors correctly', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenThrow(
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
