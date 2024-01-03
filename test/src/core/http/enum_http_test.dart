import 'package:demoafgr/src/core/http/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HTTPRequestMethod Tests', () {
    test('HTTPRequestMethod values should match their respective methods', () {
      expect(HTTPRequestMethod.get.toString(), 'HTTPRequestMethod.get');
      expect(HTTPRequestMethod.head.toString(), 'HTTPRequestMethod.head');
      expect(HTTPRequestMethod.post.toString(), 'HTTPRequestMethod.post');
      expect(HTTPRequestMethod.put.toString(), 'HTTPRequestMethod.put');
      expect(HTTPRequestMethod.delete.toString(), 'HTTPRequestMethod.delete');
      expect(HTTPRequestMethod.connect.toString(), 'HTTPRequestMethod.connect');
      expect(HTTPRequestMethod.options.toString(), 'HTTPRequestMethod.options');
      expect(HTTPRequestMethod.trace.toString(), 'HTTPRequestMethod.trace');
      expect(HTTPRequestMethod.patch.toString(), 'HTTPRequestMethod.patch');
    });
  });

  group('ContentType Tests', () {
    test('ContentType values should match their respective MIME types', () {
      expect(ContentType.json.toString(), 'application/json');
      expect(
        ContentType.formUrlEncoded.toString(),
        'application/x-www-form-urlencoded',
      );
      expect(ContentType.textPlain.toString(), 'text/plain');
      expect(ContentType.multipartFormData.toString(), 'multipart/form-data');
    });
  });
}
