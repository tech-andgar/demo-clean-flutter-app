import 'package:dio/dio.dart';
import 'package:exception_handler/exception_handler.dart';

import '../../services/services.dart';
import '../data.dart';

class ShortcutUrlRepository {
  ShortcutUrlRepository({
    required this.clientExceptionHandler,
    required this.dataSource,
  });

  final ClientExceptionHandler clientExceptionHandler;
  final ShortcutUrlRemoteDataSource dataSource;

  Future<ResultState<ShortcutUrlModel?>> postShortcutUrl(
    final String url,
  ) async {
    final result = await clientExceptionHandler
        .callApi<Response<Object?>, ShortcutUrlModel?>(
      ApiHandler<Response<Object?>, ShortcutUrlModel?>(
        apiCall: () => dataSource.newShortcutUrl(url),
        parserModel: (final result) {
          ShortcutUrlModel? dataParse;
          if (result != null) {
            dataParse =
                ShortcutUrlModel.fromJson(result as Map<String, dynamic>);
          }

          return dataParse;
        },
      ),
    );

    return result;
  }
}
