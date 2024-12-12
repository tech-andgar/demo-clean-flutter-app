import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinksModel Tests', () {
    // Test data.
    const testSelf = 'https://example.com';
    const testShort = 'https://exmpl.com';

    test('Constructor initializes properties correctly', () {
      const links = LinksModel(self: testSelf, short: testShort);
      expect(links.self, testSelf);
      expect(links.short, testShort);
    });

    test('fromJson creates correct instance', () {
      final json = <String, String>{
        'self': testSelf,
        'short': testShort,
      };
      final links = LinksModel.fromJson(json);

      expect(links.self, testSelf);
      expect(links.short, testShort);
    });

    test('toJson returns correct JSON map', () {
      const links = LinksModel(self: testSelf, short: testShort);
      final json = links.toJson();

      expect(json, <String, String>{'self': testSelf, 'short': testShort});
    });

    test('Equality comparison works correctly', () {
      const links1 = LinksModel(self: testSelf, short: testShort);
      const links2 = LinksModel(self: testSelf, short: testShort);
      const links3 = LinksModel(self: 'https://another.com', short: testShort);

      expect(links1, equals(links2));
      expect(links1, isNot(equals(links3)));
    });
  });
}
