import 'package:demoafgr/demoafgr.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('URL Validation Tests', () {
    test('Valid URLs', () {
      expect('http://foo.com/blah_blah'.isValidUrl, isTrue);
      expect('http://foo.com/blah_blah/'.isValidUrl, isTrue);
      expect('http://foo.com/blah_blah_(wikipedia)'.isValidUrl, isTrue);
      expect('http://foo.com/blah_blah_(wikipedia)_(again)'.isValidUrl, isTrue);
      expect('foo.com'.isValidUrl, isTrue);
      expect('http://www.example.com/wpstyle/?p=364'.isValidUrl, isTrue);
      expect(
        'https://www.example.com/foo/?bar=baz&inga=42&quux'.isValidUrl,
        isTrue,
      );
      expect('http://✪df.ws/123'.isValidUrl, isTrue);
      expect('http://userid:password@example.com:8080'.isValidUrl, isTrue);
      expect('http://userid:password@example.com:8080/'.isValidUrl, isTrue);
      expect('http://userid@example.com'.isValidUrl, isTrue);
      expect('http://userid@example.com/'.isValidUrl, isTrue);
      expect('http://userid@example.com:8080'.isValidUrl, isTrue);
      expect('http://userid@example.com:8080/'.isValidUrl, isTrue);
      expect('http://userid:password@example.com'.isValidUrl, isTrue);
      expect('http://userid:password@example.com/'.isValidUrl, isTrue);
      expect('http://142.42.1.1/'.isValidUrl, isTrue);
      expect('http://142.42.1.1:8080/'.isValidUrl, isTrue);
      expect('http://➡.ws/䨹'.isValidUrl, isTrue);
      expect('http://⌘.ws'.isValidUrl, isTrue);
      expect('http://⌘.ws/'.isValidUrl, isTrue);
      expect('http://foo.com/blah_(wikipedia)#cite-1'.isValidUrl, isTrue);
      expect('http://foo.com/blah_(wikipedia)_blah#cite-1'.isValidUrl, isTrue);
      expect('http://foo.com/unicode_(✪)_in_parens'.isValidUrl, isTrue);
      expect('http://foo.com/(something)?after=parens'.isValidUrl, isTrue);
      expect('http://☺.damowmow.com/'.isValidUrl, isTrue);
      expect(
        'http://code.google.com/events/#&product=browser'.isValidUrl,
        isTrue,
      );
      expect('http://j.mp'.isValidUrl, isTrue);
      expect('ftps://foo.bar/'.isValidUrl, isTrue);
      expect('ftp://foo.bar/baz'.isValidUrl, isTrue);
      expect('http://foo.bar/?q=Test%20URL-encoded%20stuff'.isValidUrl, isTrue);
      expect('http://مثال.إختبار'.isValidUrl, isTrue);
      expect('http://例子.测试'.isValidUrl, isTrue);
      expect('http://उदाहरण.परीक्षा'.isValidUrl, isTrue);
      expect(
        "http://-.~_!\$&'()*+,;=:%40:80%2f::::::@example.com".isValidUrl,
        isTrue,
      );
      expect('http://1337.net'.isValidUrl, isTrue);
      expect('http://a.b-c.de'.isValidUrl, isTrue);
      expect('http://223.255.255.254'.isValidUrl, isTrue);
      expect('postgres://u:p@example.com:5702/db'.isValidUrl, isTrue);
      expect(
        'https://d1f4470da51b49289906b3d6cbd65074@app.getsentry.com/13176'
            .isValidUrl,
        isTrue,
      );
    });
    test('Invalid URLs', () {
      expect('abc'.isValidUrl, isFalse);
      expect('http://'.isValidUrl, isFalse);
      expect('http://.'.isValidUrl, isFalse);
      expect('http://..'.isValidUrl, isFalse);
      expect('http://../'.isValidUrl, isFalse);
      expect('http://?'.isValidUrl, isFalse);
      expect('http://??'.isValidUrl, isFalse);
      expect('http://??/'.isValidUrl, isFalse);
      expect('http://#'.isValidUrl, isFalse);
      expect('http://##'.isValidUrl, isFalse);
      expect('http://##/'.isValidUrl, isFalse);
      expect('http://foo.bar?q=Spaces should be encoded'.isValidUrl, isFalse);
      expect('//'.isValidUrl, isFalse);
      expect('//a'.isValidUrl, isFalse);
      expect('///a'.isValidUrl, isFalse);
      expect('///'.isValidUrl, isFalse);
      expect('http:///a'.isValidUrl, isFalse);
      expect('rdar://1234'.isValidUrl, isFalse);
      expect('h://test'.isValidUrl, isFalse);
      expect('http:// shouldfail.com'.isValidUrl, isFalse);
      expect(':// should fail'.isValidUrl, isFalse);
      expect('http://foo.bar/foo(bar)baz quux'.isValidUrl, isFalse);
      expect('http://-error-.invalid/'.isValidUrl, isFalse);
      expect('http://a.b--c.de/'.isValidUrl, isFalse);
      expect('http://-a.b.co'.isValidUrl, isFalse);
      expect('http://a.b-.co'.isValidUrl, isFalse);
      // expect('http://0.0.0.0'.isValidUrl, isFalse);
      // expect('http://10.1.1.0'.isValidUrl, isFalse);
      // expect('http://10.1.1.255'.isValidUrl, isFalse);
      // expect('http://224.1.1.1'.isValidUrl, isFalse);
      // expect('http://1.1.1.1.1'.isValidUrl, isFalse);
      // expect('http://123.123.123'.isValidUrl, isFalse);
      // expect('http://3628126748'.isValidUrl, isFalse);
      expect('http://.www.foo.bar/'.isValidUrl, isFalse);
      expect('http://www.foo.bar./'.isValidUrl, isFalse);
      expect('http://.www.foo.bar./'.isValidUrl, isFalse);
      // expect('http://10.1.1.1'.isValidUrl, isFalse);
    });
  });

  group('UrlPrefixer Tests', () {
    test('valid ensure Https Prefix', () {
      expect('abc.abc'.ensureHttpsPrefix, 'https://abc.abc');
      expect('https://abc.abc'.ensureHttpsPrefix, 'https://abc.abc');
      expect('http://abc.abc'.ensureHttpsPrefix, 'http://abc.abc');
    });
  });
}
