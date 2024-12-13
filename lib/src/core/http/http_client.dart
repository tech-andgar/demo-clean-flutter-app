import 'enum/http_request_method.dart';

/// - [queryParameters]: Query parameters for the request.
/// - [headers]: HTTP headers for the request.
class HttpRequestOptions {
  const HttpRequestOptions({
    this.queryParameters,
    this.headers,
  });

  final Map<String, Object?>? headers;
  final Map<String, Object?>? queryParameters;
}

/// Interface for an HTTP client to make RESTful API requests.
///
/// All methods return a [Future] containing the response or `null` if no response is expected.
abstract class HttpClient {
  /// Sends a DELETE request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> delete(
    final String url, {
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.delete,
      options: options,
    );
  }

  /// Sends a GET request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> get(
    final String url, {
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.get,
      options: options,
    );
  }

  /// Sends a HEAD request to the given [url].
  ///
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> head(
    final String url, {
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.head,
      options: options,
    );
  }

  /// Sends a PATCH request to the given [url].
  ///
  /// - [body]: The body of the request.
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> patch(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.patch,
      body: body,
      options: options,
    );
  }

  /// Sends a POST request to the given [url].
  ///
  /// - [body]: The body of the request.
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> post(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.post,
      body: body,
      options: options,
    );
  }

  /// Sends a PUT request to the given [url].
  ///
  /// - [body]: The body of the request.
  /// - [options]: Optional parameters including headers and query parameters.
  Future<Object?> put(
    final String url, {
    final Object? body,
    final HttpRequestOptions? options,
  }) {
    return request(
      url,
      method: HTTPRequestMethod.put,
      body: body,
      options: options,
    );
  }

  /// Sends an HTTP request to the given [url] with the specified [method].
  ///
  /// - [method]: The HTTP method (GET, POST, etc.).
  /// - [body]: The body of the request (for POST, PUT, PATCH).
  /// - [options]: Optional parameters including headers, query parameters, and body.
  Future<Object?> request(
    final String url, {
    required final HTTPRequestMethod method,
    final Object? body,
    final HttpRequestOptions? options,
  });
}
