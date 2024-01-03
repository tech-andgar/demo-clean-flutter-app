import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/data.dart';

class ShortcutUrlRemoteDataSource {
  ShortcutUrlRemoteDataSource([HttpClient? httpClient])
      : httpClient_ = httpClient ??
            DioAdapterHttpClient(
              'https://url-shortener-server.onrender.com/api/',
            );

  final HttpClient httpClient_;

  Future<Response> newShortcutUrl(String url) async {
    final Map urlModel = UrlModel(url).toJson();
    final response = await httpClient_.post('alias', body: urlModel);
    return response;
  }
}
