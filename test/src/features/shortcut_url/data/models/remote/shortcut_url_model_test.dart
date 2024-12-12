import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShortcutUrlModel Tests', () {
    // Test data.
    const testAlias = 'exampleAlias';
    const testLinks =
        LinksModel(self: 'https://example.com', short: 'https://exmpl.com');

    test('Constructor initializes properties correctly', () {
      const shortcut = ShortcutUrlModel(alias: testAlias, links: testLinks);
      expect(shortcut.alias, testAlias);
      expect(shortcut.links, testLinks);
    });

    test('fromJson creates correct instance', () {
      final json = <String, Object>{
        'alias': testAlias,
        '_links': <String, String>{
          'self': testLinks.self,
          'short': testLinks.short,
        },
      };
      final shortcut = ShortcutUrlModel.fromJson(json);

      expect(shortcut.alias, testAlias);
      expect(shortcut.links, equals(testLinks));
    });

    test('toJson returns correct JSON map', () {
      const shortcut = ShortcutUrlModel(alias: testAlias, links: testLinks);
      final json = shortcut.toJson();

      expect(json, <String, Object>{
        'alias': testAlias,
        '_links': <String, String>{
          'self': testLinks.self,
          'short': testLinks.short,
        },
      });
    });

    test('Equality comparison works correctly', () {
      const shortcut1 = ShortcutUrlModel(alias: testAlias, links: testLinks);
      const shortcut2 = ShortcutUrlModel(alias: testAlias, links: testLinks);
      const shortcut3 =
          ShortcutUrlModel(alias: 'differentAlias', links: testLinks);

      expect(shortcut1, equals(shortcut2));
      expect(shortcut1, isNot(equals(shortcut3)));
    });
  });
}
