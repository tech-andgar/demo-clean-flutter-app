import 'enum/http_request_method.dart';

abstract class HttpClient {
  Future<Object?> get(
    final String url, {
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  Future<Object?> post(
    final String url, {
    final Object? body,
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  Future<Object?> put(
    final String url, {
    final Object? body,
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  Future<Object?> delete(
    final String url, {
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  Future<Object?> patch(
    final String url, {
    final Object? body,
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  Future<Object?> head(
    final String url, {
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });

  /// Generic method for handling requests.
  Future<Object?> request(
    final String url, {
    required final HTTPRequestMethod method,
    final Object? body,
    final Map<String, Object?>? queryParameters,
    final Map<String, Object?>? headers,
  });
}
