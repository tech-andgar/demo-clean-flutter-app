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
  NotificationMessage(this.type, this.message);

  final String message;
  final NotificationType type;
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
    final ResultState<ShortcutUrlModel?> result =
        await shortcutUrlRepository.postShortcutUrl(url.ensureHttpsPrefix);

    late bool isSuccess;
    switch (result) {
      case final SuccessState<ShortcutUrlModel?> successData:
        if (successData.data != null) {
          notifierItemsShortcutUrls.value.insert(0, successData.data!);
        }
        isSuccess = true;
      case final FailureState<ShortcutUrlModel?> failureData:
        final String msgException = switch (failureData.exception) {
          final DataClientExceptionState<ShortcutUrlModel?> dataClientExceptionState =>
            'Error Client: ${dataClientExceptionState.message.toString().split('.')[1]}',
          final DataParseExceptionState<ShortcutUrlModel?> dataParseExceptionState =>
            'Error Data Parse: ${dataParseExceptionState.message.toString()}',
          final DataHttpExceptionState<ShortcutUrlModel?> dataHttpExceptionState =>
            'Error HTTP ${dataHttpExceptionState.httpException.httpStatus.code}: ${'core.httpCode.${dataHttpExceptionState.httpException.httpStatus.code}'.tr()}',
          final DataNetworkExceptionState<ShortcutUrlModel?> dataNetworkExceptionState =>
            'Error Network: '
                '${'NetworkException.noInternetConnection' == dataNetworkExceptionState.message ? LocaleKeys.core_exception_networkNoInternetConnection.tr() : LocaleKeys.core_httpCode_408.tr()}',
          _ => 'Error Unknown: ${failureData.exception}',
        };

        notifierNotificationMessage.value =
            NotificationMessage(NotificationType.error, msgException);
        isSuccess = false;
    }

    hideLoading();
    return isSuccess;
  }

  bool isMatchSame(List<ShortcutUrlModel> items, String url) =>
      items.any((ShortcutUrlModel item) => item.links.self == url);
}
