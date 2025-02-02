import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../common/common.dart';
import '../../../core/core.dart';
import '../bloc/bloc.dart';
import 'widget/widget.dart';

class ShortcutUrlScreen extends StatefulWidget {
  const ShortcutUrlScreen({required this.shortcutUrlBloc, super.key});

  final ShortcutUrlBloc shortcutUrlBloc;

  @override
  State<ShortcutUrlScreen> createState() => _ShortcutUrlScreenState();
}

class _ShortcutUrlScreenState extends State<ShortcutUrlScreen> {
  late final TextEditingController _textUrlController;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<NotificationMessage?>(
        valueListenable: widget.shortcutUrlBloc.notifierNotificationMessage,
        builder: (final context, final notification, final child) {
          if (notification != null && mounted) {
            Future<void>.microtask(
              // ignore: use_build_context_synchronously
              () => CdsSnackBar.show(context, notification.message),
            );
            widget.shortcutUrlBloc.notifierNotificationMessage.value = null;
          }

          return child!;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              centerTitle: true,
              title: Text('Demo AFGR'),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CdsChangeLanguage(),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CdsInputButton(
                  controller: _textUrlController,
                  onPressed: () {
                    if (_textUrlController.text == '') {
                      CdsSnackBar.show(
                        context,
                        LocaleKeys.core_exception_urlEmptyInput.tr(),
                      );
                    } else {
                      widget.shortcutUrlBloc
                          .generateShortcutUrl(_textUrlController.text)
                          .then((final isSuccess) {
                        if (isSuccess) {
                          _textUrlController.clear();
                        }
                      });
                    }
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  LocaleKeys.feature_mainShortcutUrl_title.tr(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListenableBuilder(
              listenable: Listenable.merge(<Listenable?>[
                widget.shortcutUrlBloc.notifierItemsShortcutUrls,
                widget.shortcutUrlBloc.notifierLoading,
              ]),
              builder: (final context, final _) {
                return widget.shortcutUrlBloc.isEmptyData
                    ? SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 64,
                          horizontal: 16,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              LocaleKeys
                                  .feature_mainShortcutUrl_sliverListUrl_dataEmpty
                                  .tr(),
                            ),
                          ),
                        ),
                      )
                    : UiWidgetListItems(widget: widget);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _textUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _textUrlController.dispose();
    widget.shortcutUrlBloc.dispose();
    super.dispose();
  }
}

class UiWidgetListItems extends StatelessWidget {
  const UiWidgetListItems({
    required this.widget,
    super.key,
  });

  final ShortcutUrlScreen widget;

  @override
  Widget build(final BuildContext context) {
    final shortcutUrlBloc = widget.shortcutUrlBloc;
    final itemsShortcutUrls = shortcutUrlBloc.itemsShortcutUrls;

    return SliverList.separated(
      itemCount: shortcutUrlBloc.isLoading
          ? itemsShortcutUrls.length + 1
          : itemsShortcutUrls.length,
      itemBuilder: (final _, final index) {
        if (shortcutUrlBloc.isLoading && index == 0) {
          return const CdsItemLoading();
        } else {
          final indexUpdated = shortcutUrlBloc.isLoading ? index - 1 : index;

          return CdsItemListTileShortcutUrl(
            itemsShortcutUrls[indexUpdated],
            clipboard: (final clipboardData) async {
              await Clipboard.setData(clipboardData);

              return null;
            },
          );
        }
      },
      separatorBuilder: (final _, final __) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(),
      ),
    );
  }
}
