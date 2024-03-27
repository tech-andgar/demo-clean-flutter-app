import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlModel Tests', () {
    const String testUrl = 'https://example.com';

    test('Constructor initializes properties correctly', () {
      const UrlModel urlModel = UrlModel(testUrl);
      expect(urlModel.url, testUrl);
    });

    test('fromJson creates correct instance', () {
      final Map<String, String> json = <String, String>{'url': testUrl};
      final UrlModel urlModel = UrlModel.fromJson(json);

      expect(urlModel.url, testUrl);
    });

    test('toJson returns correct JSON map', () {
      const UrlModel urlModel = UrlModel(testUrl);
      final Map<String, dynamic> json = urlModel.toJson();

      expect(json, <String, String>{'url': testUrl});
    });

    test('Equality comparison works correctly', () {
      const UrlModel urlModel1 = UrlModel(testUrl);
      const UrlModel urlModel2 = UrlModel(testUrl);
      const UrlModel urlModel3 = UrlModel('https://anotherexample.com');

      expect(urlModel1, equals(urlModel2));
      expect(urlModel1, isNot(equals(urlModel3)));
    });
  });
}
