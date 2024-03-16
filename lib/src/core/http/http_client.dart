import 'enum_http.dart';

abstract class HttpClient {
  Future<Object?> get(
    String url, {
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Object?> post(
    String url, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Object?> put(
    String url, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Object?> delete(
    String url, {
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Object?> patch(
    String url, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Object?> head(
    String url, {
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  /// Generic method for handling requests
  Future<Object?> request(
    String url, {
    required HTTPRequestMethod method,
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });
}
