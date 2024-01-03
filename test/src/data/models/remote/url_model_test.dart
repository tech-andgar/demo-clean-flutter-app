import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlModel Tests', () {
    const String testUrl = 'https://example.com';

    test('Constructor initializes properties correctly', () {
      const urlModel = UrlModel(testUrl);
      expect(urlModel.url, testUrl);
    });

    test('fromJson creates correct instance', () {
      final json = {'url': testUrl};
      final urlModel = UrlModel.fromJson(json);

      expect(urlModel.url, testUrl);
    });

    test('toJson returns correct JSON map', () {
      const urlModel = UrlModel(testUrl);
      final json = urlModel.toJson();

      expect(json, {'url': testUrl});
    });

    test('Equality comparison works correctly', () {
      const urlModel1 = UrlModel(testUrl);
      const urlModel2 = UrlModel(testUrl);
      const urlModel3 = UrlModel('https://anotherexample.com');

      expect(urlModel1, equals(urlModel2));
      expect(urlModel1, isNot(equals(urlModel3)));
    });
  });
}
