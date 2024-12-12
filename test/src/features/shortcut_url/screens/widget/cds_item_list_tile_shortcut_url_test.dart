import 'package:demoafgr/demoafgr.dart';
import 'package:demoafgr/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';

void main() {
  EasyLocalization.logger.enableLevels = <LevelMessages>[];
  group(
    'CdsItemListTileShortcutUrl Tests',
    () {
      late ShortcutUrlModel mockItem;

      setUp(
        () {
          mockItem = const ShortcutUrlModel(
            alias: 'TestAlias',
            links: LinksModel(
              self: 'https://example.com',
              short: 'https://exmpl.co',
            ),
          );
        },
      );

      testWidgets(
        'should display correct data',
        (final tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CdsItemListTileShortcutUrl(
                  mockItem,
                  clipboard: (final clipboardData) async => null,
                ),
              ),
            ),
          );

          expect(find.text('https://example.com'), findsOneWidget);
          expect(find.text('https://exmpl.co'), findsOneWidget);
        },
      );

      testWidgets(
        'copy button should copy short link to clipboard',
        (final tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CdsItemListTileShortcutUrl(
                  mockItem,
                  clipboard: (final data) async {
                    await MockClipboard.setData(data);

                    return null;
                  },
                ),
              ),
            ),
          );

          await tester.tap(find.byIcon(Icons.copy));
          await tester.pump();

          final clipboardData = await MockClipboard.getData('text/plain');

          expect(clipboardData.text, equals(mockItem.links.short));

          expect(
            find.text(
              LocaleKeys
                  .widget_cdsItemListTileShortcutUrl_iconButton_onPressed_msgSnackbar
                  .tr(
                namedArgs: <String, String>{
                  'linkShortend': mockItem.links.self,
                },
              ),
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
