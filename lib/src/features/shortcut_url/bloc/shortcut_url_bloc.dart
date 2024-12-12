import 'package:easy_localization/easy_localization.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../common/common.dart';
import '../../../core/core.dart';
import '../data/data.dart';

class ShortcutUrlBloc {
  ShortcutUrlBloc({required this.shortcutUrlRepository});

  final ValueNotifier<List<ShortcutUrlModel>> notifierItemsShortcutUrls =
      ValueNotifier<List<ShortcutUrlModel>>(<ShortcutUrlModel>[]);

  final ValueNotifier<bool> notifierLoading = ValueNotifier<bool>(false);
  final ValueNotifier<NotificationMessage?> notifierNotificationMessage =
      ValueNotifier<NotificationMessage?>(null);

  final ShortcutUrlRepository shortcutUrlRepository;

  List<ShortcutUrlModel> get itemsShortcutUrls =>
      notifierItemsShortcutUrls.value;

  bool get isLoading => notifierLoading.value;
  bool get isEmptyData => notifierItemsShortcutUrls.value.isEmpty && !isLoading;

  void showLoading() => notifierLoading.value = true;

  void hideLoading() => notifierLoading.value = false;

  void dispose() {
    notifierItemsShortcutUrls.dispose();
    notifierLoading.dispose();
    notifierNotificationMessage.dispose();
  }

  Future<bool> generateShortcutUrl(final String url) async {
    var isSuccess = false;

    if (!url.isValidUrl) {
      notifierNotificationMessage.value = NotificationMessage(
        NotificationType.error,
        LocaleKeys.core_exception_urlInvalidInput.tr(),
      );

      return isSuccess;
    }

    final isMatched =
        isMatchSame(notifierItemsShortcutUrls.value, url.ensureHttpsPrefix);

    if (isMatched) {
      notifierNotificationMessage.value = NotificationMessage(
        NotificationType.error,
        LocaleKeys.core_exception_urlDuplicateExist.tr(),
      );

      return isSuccess;
    }

    showLoading();
    final result =
        await shortcutUrlRepository.postShortcutUrl(url.ensureHttpsPrefix);

    switch (result) {
      case final SuccessState<ShortcutUrlModel?> successData:
        if (successData.data != null) {
          notifierItemsShortcutUrls.value.insert(0, successData.data!);
        }
        isSuccess = true;

      case final FailureState<ShortcutUrlModel?> failureData:
        final msgException = switch (failureData.exception) {
          final DataClientExceptionState<ShortcutUrlModel?>
            dataClientExceptionState =>
            'Error Client: ${dataClientExceptionState.message.toString().split('.')[1]}',
          final DataParseExceptionState<ShortcutUrlModel?>
            dataParseExceptionState =>
            'Error Data Parse: ${dataParseExceptionState.message.toString()}',
          final DataHttpExceptionState<ShortcutUrlModel?>
            dataHttpExceptionState =>
            'Error HTTP ${dataHttpExceptionState.httpException.httpStatus.code}: ${'core.httpCode.${dataHttpExceptionState.httpException.httpStatus.code}'.tr()}',
          final DataNetworkExceptionState<ShortcutUrlModel?>
            dataNetworkExceptionState =>
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

  bool isMatchSame(final List<ShortcutUrlModel> items, final String url) =>
      items.any(
        (final item) => item.links.self == url,
      );
}
