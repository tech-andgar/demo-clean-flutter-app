import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinksModel Tests', () {
    // Test data.
    const String testSelf = 'https://example.com';
    const String testShort = 'https://exmpl.com';

    test('Constructor initializes properties correctly', () {
      const LinksModel links = LinksModel(self: testSelf, short: testShort);
      expect(links.self, testSelf);
      expect(links.short, testShort);
    });

    test('fromJson creates correct instance', () {
      final Map<String, String> json = <String, String>{
        'self': testSelf,
        'short': testShort,
      };
      final LinksModel links = LinksModel.fromJson(json);

      expect(links.self, testSelf);
      expect(links.short, testShort);
    });

    test('toJson returns correct JSON map', () {
      const LinksModel links = LinksModel(self: testSelf, short: testShort);
      final Map<String, Object?> json = links.toJson();

      expect(json, <String, String>{'self': testSelf, 'short': testShort});
    });

    test('Equality comparison works correctly', () {
      const LinksModel links1 = LinksModel(self: testSelf, short: testShort);
      const LinksModel links2 = LinksModel(self: testSelf, short: testShort);
      const LinksModel links3 =
          LinksModel(self: 'https://another.com', short: testShort);

      expect(links1, equals(links2));
      expect(links1, isNot(equals(links3)));
    });
  });
}
