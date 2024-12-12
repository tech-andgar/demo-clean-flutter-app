import 'package:dio/dio.dart';

import '../../enum/http_request_method.dart';
import '../../http_client.dart';

class DioAdapterHttpClient implements HttpClient {
  DioAdapterHttpClient(
    final String baseUrl, {
    final Map<String, Object?>? defaultHeaders,
    final Dio? dio,
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
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> delete(
    final String url, {
    final HttpRequestOptions? options,
  }) async =>
      await _dio.delete(url, options: Options(headers: options?.headers));

  /// Sends a HTTP GET request.
  ///
  /// [url] is the endpoint URL.
  /// [options]: Optional parameters including headers and query parameters.
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
  Future<Response<Object?>> get(
    final String url, {
    final HttpRequestOptions? options,
  }) async =>
      await _dio.get(
        url,
        queryParameters: options?.queryParameters,
        options: Options(headers: options?.headers),
      );

  /// Sends a HTTP HEAD request.
  ///
  /// [url] is the endpoint URL.
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> head(
    final String url, {
    final HttpRequestOptions? options,
  }) async =>
      await _dio.head(url, options: Options(headers: options?.headers));

  /// Sends a HTTP PATCH request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> patch(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) async =>
      await _dio.patch(
        url,
        data: body,
        options: Options(headers: options?.headers),
      );

  /// Sends a HTTP POST request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> post(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) async =>
      await _dio.post(
        url,
        data: body,
        options: Options(headers: options?.headers),
      );

  /// Sends a HTTP PUT request.
  ///
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> put(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) async =>
      await _dio.put(
        url,
        data: body,
        options: Options(headers: options?.headers),
      );

  /// Sends a HTTP request with a specified [method].
  ///
  /// [method] is the HTTP method (GET, POST, etc.).
  /// [url] is the endpoint URL.
  /// [body] is the request body data.
  /// [options]: Optional parameters including headers and query parameters.
  @override
  Future<Response<Object?>> request(
    final String url, {
    required final HTTPRequestMethod method,
    final Object? body,
    final HttpRequestOptions? options,
  }) async =>
      await _dio.request(
        url,
        queryParameters: options?.queryParameters,
        data: body,
        options: Options(method: method.name, headers: options?.headers),
      );

  /// Updates the base URL of the Dio instance.
  ///
  /// [newBaseUrl] is the new base URL to be set.
  // ignore: use_setters_to_change_properties
  void updateBaseUrl(final String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
}
