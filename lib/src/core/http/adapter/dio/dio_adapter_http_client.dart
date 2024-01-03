import 'package:dio/dio.dart';

import '../../enum_http.dart';
import '../../http_client.dart';

class DioAdapterHttpClient implements HttpClient {
  DioAdapterHttpClient(
    String baseUrl, {
    Map<String, dynamic>? defaultHeaders,
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                headers: defaultHeaders,
                contentType: Headers.jsonContentType,
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
              ),
            );

  late final Dio _dio;

  /// Sends a HTTP DELETE request.
  ///
  /// [url] is the endpoint URL.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response =
        await _dio.delete(url, options: Options(headers: headers));
    return response;
  }

  /// Sends a HTTP GET request.
  ///
  /// [url] is the endpoint URL.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  ///
  /// Example usage:
  /// ```dart
  /// var dioService = DioServiceImpl('https://api.example.com');
  ///
  /// await dioService.get(
  ///   '/endpoint',
  ///   queryParameters: {
  ///     'param1': 'value1',
  ///     'param2': 'value2',
  ///   },
  /// );
  /// ```
  /// This will append `param1=value1&param2=value2` to the request URL,
  /// resulting in `https://api.example.com/endpoint?param1=value1&param2=value2`.
  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  /// Sends a HTTP HEAD request.
  ///
  /// [url] is the endpoint URL.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> head(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response =
        await _dio.head(url, options: Options(headers: headers));
    return response;
  }

  /// Sends a HTTP PATCH request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response =
        await _dio.patch(url, data: body, options: Options(headers: headers));
    return response;
  }

  /// Sends a HTTP POST request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response =
        await _dio.post(url, data: body, options: Options(headers: headers));
    return response;
  }

  /// Sends a HTTP PUT request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response =
        await _dio.put(url, data: body, options: Options(headers: headers));
    return response;
  }

  /// Sends a HTTP request with a specified [method].
  ///
  /// [method] is the HTTP method (GET, POST, etc.).
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [queryParameters] are the optional query parameters.
  /// [headers] are the optional HTTP headers.
  @override
  Future<Response> request(
    String url, {
    required HTTPRequestMethod method,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final Response<dynamic> response = await _dio.request(
      url,
      queryParameters: queryParameters,
      data: body,
      options: Options(method: method.name, headers: headers),
    );
    return response;
  }

  /// Updates the base URL of the Dio instance.
  ///
  /// [newBaseUrl] is the new base URL to be set.
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
}
