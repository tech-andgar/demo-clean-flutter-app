import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/locale_keys.g.dart';
import '../../bloc/bloc.dart';
import '../../common/common.dart';
import 'widget/widget.dart';

class ShortUrlScreen extends StatefulWidget {
  const ShortUrlScreen({super.key, required this.shortcutUrlBloc});
  final ShortcutUrlBloc shortcutUrlBloc;

  @override
  State<ShortUrlScreen> createState() => _ShortUrlScreenState();
}

class _ShortUrlScreenState extends State<ShortUrlScreen> {
  late final TextEditingController _textUrlController;

  @override
  void dispose() {
    _textUrlController.dispose();
    widget.shortcutUrlBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _textUrlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<NotificationMessage?>(
        valueListenable: widget.shortcutUrlBloc.notifierNotificationMessage,
        builder: (context, message, child) {
          if (message != null) {
            Future.microtask(() => CdsSnackBar.show(context, message.message));
            widget.shortcutUrlBloc.notifierNotificationMessage.value = null;
          }

          return child!;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: const Text('Demo AFGR'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CdsChangeLanguage(() => setState(() {})),
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
                          .then((isSuccess) {
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
                  LocaleKeys.feature_main_title.tr(),
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
              builder: (BuildContext context, _) {
                if (widget.shortcutUrlBloc.notifierItemsShortcutUrls.value
                        .isEmpty &&
                    !widget.shortcutUrlBloc.isLoading) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 16,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          LocaleKeys.feature_main_sliverListUrl_dataEmpty.tr(),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverList.separated(
                    itemCount: widget.shortcutUrlBloc.isLoading
                        ? widget.shortcutUrlBloc.itemsShortcutUrls.length + 1
                        : widget.shortcutUrlBloc.itemsShortcutUrls.length,
                    itemBuilder: (_, int index) {
                      if (widget.shortcutUrlBloc.isLoading && index == 0) {
                        return const CdsItemLoading();
                      } else {
                        return CdsItemListTileShortcutUrl(
                          widget.shortcutUrlBloc.itemsShortcutUrls[
                              widget.shortcutUrlBloc.isLoading
                                  ? index - 1
                                  : index],
                          clipboard: (ClipboardData clipboardData) async {
                            await Clipboard.setData(clipboardData);
                          },
                        );
                      }
                    },
                    separatorBuilder: (_, __) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
