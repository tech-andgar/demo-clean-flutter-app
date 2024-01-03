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

  Future<TaskResult<ShortcutUrlModel?>> postShortcutUrl(String url) async {
    final TaskResult<ShortcutUrlModel?> taskResult =
        await clientExceptionHandler.callApi<Response, ShortcutUrlModel?>(
      ApiHandler<Response, ShortcutUrlModel?>(
        apiCall: () => dataSource.newShortcutUrl(url),
        parserModel: (Object? result) {
          ShortcutUrlModel? dataParse;
          if (result != null) {
            dataParse =
                ShortcutUrlModel.fromJson(result as Map<String, dynamic>);
          }
          return dataParse;
        },
      ),
    );
    return taskResult;
  }
}
