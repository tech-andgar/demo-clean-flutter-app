import 'package:demoafgr/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/widgets/widgets.dart';
import '../../data/data.dart';

class CdsItemListTileShortcutUrl extends StatelessWidget {
  const CdsItemListTileShortcutUrl(
    this.item, {
    required this.clipboard,
    super.key,
  });

  final ShortcutUrlModel item;
  final Future<Object?> Function(ClipboardData) clipboard;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(item.links.self),
        subtitle: Text(item.links.short),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            _onPressed(context);
          },
        ),
      );

  Future<void> _onPressed(BuildContext context) async {
    await clipboard(ClipboardData(text: item.links.short));

    if (!context.mounted) {
      return;
    }

    CdsSnackBar.show(
      context,
      LocaleKeys
          .widget_cdsItemListTileShortcutUrl_iconButton_onPressed_msgSnackbar
          .tr(namedArgs: {'linkShortend': item.links.self}),
    );
  }
}
