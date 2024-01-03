import 'package:demoafgr/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/widgets/widgets.dart';
import '../../../data/models/models.dart';

class CdsItemListTileShortcutUrl extends StatelessWidget {
  const CdsItemListTileShortcutUrl(
    this.item, {
    super.key,
    required this.clipboard,
  });

  final ShortcutUrlModel item;
  final Future Function(ClipboardData) clipboard;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.links.self),
      subtitle: Text(item.links.short),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          _onPressed(context);
        },
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    clipboard(ClipboardData(text: item.links.short));

    if (!context.mounted) return;

    CdsSnackBar.show(
      context,
      LocaleKeys
          .widget_cdsItemListTileShortcutUrl_iconButton_onPressed_msgSnackbar
          .tr(namedArgs: {'linkShortend': item.links.self}),
    );
  }
}
