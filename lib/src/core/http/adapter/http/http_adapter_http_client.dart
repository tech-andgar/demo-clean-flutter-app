import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../enum_http.dart';
import '../../http_client.dart';

class HttpAdapterHttpClient implements HttpClient {
  HttpAdapterHttpClient({http.Client? client})
      : httpClient = client ?? http.Client();

  final http.Client httpClient;

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final http.Response response = await httpClient.delete(Uri.parse(url));
    return _processResponse(response);
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final http.Response response = await httpClient
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on TimeoutException catch (_) {
      throw TimeoutException('The connection has timed out, Please try again!');
    }
  }

  @override
  Future<dynamic> head(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final http.Response response = await httpClient.head(Uri.parse(url));
    return _processResponse(response);
  }

  @override
  Future<dynamic> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final http.Response response = await httpClient.patch(Uri.parse(url));
    return _processResponse(response);
  }

  @override
  Future<dynamic> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final http.Response response =
        await httpClient.post(Uri.parse(url), body: body);
    return _processResponse(response);
  }

  @override
  Future<dynamic> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final http.Response response = await httpClient.put(Uri.parse(url));
    return _processResponse(response);
  }

  @override
  Future<dynamic> request(
    String url, {
    required HTTPRequestMethod method,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Uri uri = Uri.parse(url);
    final http.Request request = http.Request(method.name, uri);

    _logRequest(request);

    if (body != null) {
      request.body = json.encode(body);
    }
    final http.Response response =
        await http.Response.fromStream(await request.send());
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw HttpException('Failed to load data', uri: response.request?.url);
    }
  }

  void _logRequest(http.Request request) {
    debugPrint('Request URL: ${request.url}');
    debugPrint('Request Headers: ${request.headers}');
    debugPrint('Request Method: ${request.method}');
  }
}
