import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../common/common.dart';
import '../data/data.dart';

enum NotificationType {
  error,
  success,
}

class NotificationMessage {
  final NotificationType type;
  final String message;

  NotificationMessage(this.type, this.message);
}

class ShortcutUrlBloc {
  ShortcutUrlBloc({required this.shortcutUrlRepository});

  final ShortcutUrlRepository shortcutUrlRepository;

  final ValueNotifier<List<ShortcutUrlModel>> notifierItemsShortcutUrls =
      ValueNotifier<List<ShortcutUrlModel>>([]);
  List<ShortcutUrlModel> get itemsShortcutUrls =>
      notifierItemsShortcutUrls.value;

  final notifierLoading = ValueNotifier<bool>(false);
  bool get isLoading => notifierLoading.value;
  void showLoading() => notifierLoading.value = true;
  void hideLoading() => notifierLoading.value = false;

  final ValueNotifier<NotificationMessage?> notifierNotificationMessage =
      ValueNotifier(null);

  void dispose() {
    notifierItemsShortcutUrls.dispose();
    notifierLoading.dispose();
    notifierNotificationMessage.dispose();
  }

  Future<bool> generateShortcutUrl(String url) async {
    if (!url.isValidUrl) {
      notifierNotificationMessage.value = NotificationMessage(
        NotificationType.error,
        LocaleKeys.core_exception_urlInvalidInput.tr(),
      );
      return false;
    }

    final match = isMatchSame(notifierItemsShortcutUrls.value, url);
    if (match) {
      notifierNotificationMessage.value = NotificationMessage(
        NotificationType.error,
        LocaleKeys.core_exception_urlDuplicateExist.tr(),
      );
      return false;
    }

    showLoading();
    final TaskResult<ShortcutUrlModel?> result =
        await shortcutUrlRepository.postShortcutUrl(url.ensureHttpsPrefix);

    late bool isSuccess;
    result.when(
      success: (ShortcutUrlModel? data) {
        if (data != null) {
          notifierItemsShortcutUrls.value.insert(0, data);
        }
        isSuccess = true;
      },
      failure: (ExceptionState<ShortcutUrlModel?> exception) {
        final String msgException = switch (exception) {
          final DataClientException dataClientException =>
            'Error Client: ${dataClientException.clientException.toString().split('.')[1]}',
          final DataParseException dataParseException =>
            'Error Data Parse: ${dataParseException.parseException.toString()}',
          final DataHttpException dataHttpException =>
            'Error HTTP ${dataHttpException.statusCode}: ${'core.http_code.${dataHttpException.statusCode}'.tr()}',
          final DataNetworkException dataNetworkException => 'Error Network: '
              '${NetworkException.noInternetConnection == dataNetworkException.networkException ? LocaleKeys.core_exception_networkNoInternetConnection.tr() : LocaleKeys.core_httpCode_408.tr()}',
        };

        notifierNotificationMessage.value =
            NotificationMessage(NotificationType.error, msgException);

        isSuccess = false;
      },
    );
    hideLoading();
    return isSuccess;
  }

  bool isMatchSame(List<ShortcutUrlModel> items, String url) =>
      items.any((ShortcutUrlModel item) => item.links.self == url);
}
