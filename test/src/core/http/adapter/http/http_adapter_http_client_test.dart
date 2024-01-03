import 'dart:async';
import 'dart:io';

import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('HttpAdapterHttpClient Tests', () {
    late HttpAdapterHttpClient client;
    late MockClient mockClient;

    setUpAll(() {
      registerFallbackValue(MockBaseRequest());
    });

    setUp(() {
      mockClient = MockClient();
      client = HttpAdapterHttpClient(client: mockClient);
    });

    test('Sends GET request correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('{"data": "test"}', 200));

      final response = await client.get(url);
      expect(response, {'data': 'test'});

      verify(() => mockClient.get(Uri.parse(url))).called(1);
    });

    test('Sends POST request correctly', () async {
      const url = 'https://example.com';
      const postData = {'key': 'value'};
      when(() => mockClient.post(Uri.parse(url), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"result": "success"}', 200));

      final response = await client.post(url, body: postData);
      expect(response, {'result': 'success'});

      verify(() => mockClient.post(Uri.parse(url), body: any(named: 'body')))
          .called(1);
    });
    test('Sends PUT request correctly', () async {
      const url = 'https://example.com';
      const putData = {'key': 'value'};
      when(() => mockClient.put(Uri.parse(url), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"result": "updated"}', 200));

      final response = await client.put(url, body: putData);
      expect(response, {'result': 'updated'});

      verify(() => mockClient.put(Uri.parse(url), body: any(named: 'body')))
          .called(1);
    });

    test('Sends DELETE request correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.delete(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('{"result": "deleted"}', 200));

      final response = await client.delete(url);
      expect(response, {'result': 'deleted'});

      verify(() => mockClient.delete(Uri.parse(url))).called(1);
    });

    test('Sends PATCH request correctly', () async {
      const url = 'https://example.com';
      const patchData = {'key': 'new-value'};
      when(() => mockClient.patch(Uri.parse(url), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"result": "patched"}', 200));

      final response = await client.patch(url, body: patchData);
      expect(response, {'result': 'patched'});

      verify(() => mockClient.patch(Uri.parse(url), body: any(named: 'body')))
          .called(1);
    });

    test('Handles network errors correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.get(Uri.parse(url)))
          .thenThrow(const SocketException('No Internet connection'));

      expect(
        () async => await client.get(url),
        throwsA(isA<SocketException>()),
      );
    });

    test('Processes non-200 responses correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Error occurred', 404));

      expect(() async => await client.get(url), throwsA(isA<HttpException>()));
    });
    test('Handles timeout errors correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.get(Uri.parse(url)))
          .thenThrow(TimeoutException('Request timed out'));

      expect(
        () async => await client.get(url),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('Processes invalid JSON responses correctly', () async {
      const url = 'https://example.com';
      when(() => mockClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Invalid JSON', 200));

      expect(
        () async => await client.get(url),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
