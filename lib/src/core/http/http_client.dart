import 'enum/http_request_method.dart';

class HttpRequestOptions {
  const HttpRequestOptions({
    this.body,
    this.queryParameters,
    this.headers,
  });

  final Object? body;
  final Map<String, Object?>? headers;
  final Map<String, Object?>? queryParameters;
}

/// Interface for an HTTP client to make RESTful API requests.
///
/// All methods return a [Future] containing the response or `null` if no response is expected.
abstract class HttpClient {
  /// Sends an HTTP request to the given [url] with the specified [method].
  ///
  /// - [method]: The HTTP method (GET, POST, etc.).
  /// - [options]: Optional parameters including headers, query parameters, and body.
  Future<Object?> request(
    final String url, {
    required final HTTPRequestMethod method,
    final HttpRequestOptions? options,
  });

  /// Sends a GET request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> get(final String url, {final HttpRequestOptions? options}) =>
      request(url, method: HTTPRequestMethod.get, options: options);

  /// Sends a POST request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> post(final String url, {final HttpRequestOptions? options}) =>
      request(url, method: HTTPRequestMethod.post, options: options);

  /// Sends a PUT request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> put(final String url, {final HttpRequestOptions? options}) =>
      request(url, method: HTTPRequestMethod.put, options: options);

  /// Sends a DELETE request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> delete(
    final String url, {
    final HttpRequestOptions? options,
  }) =>
      request(url, method: HTTPRequestMethod.delete, options: options);

  /// Sends a PATCH request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> patch(
    final String url, {
    final HttpRequestOptions? options,
  }) =>
      request(url, method: HTTPRequestMethod.patch, options: options);

  /// Sends a HEAD request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> head(final String url, {final HttpRequestOptions? options}) =>
      request(url, method: HTTPRequestMethod.head, options: options);
}
