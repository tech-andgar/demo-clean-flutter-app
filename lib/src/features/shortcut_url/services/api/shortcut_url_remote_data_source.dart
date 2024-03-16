import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';

class ShortcutUrlRemoteDataSource {
  ShortcutUrlRemoteDataSource([HttpClient? httpClient])
      : httpClient_ = httpClient ??
            DioAdapterHttpClient(
              'https://url-shortener-server.onrender.com/api/',
            );

  final HttpClient httpClient_;

  Future<Response<Object?>> newShortcutUrl(String url) async {
    final Map<String, Object?> urlModel = UrlModel(url).toJson();
    final response =
        await httpClient_.post('alias', body: urlModel) as Response<Object?>;
    return response;
  }
}
