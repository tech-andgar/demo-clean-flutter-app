extension UrlValidator on String {
  bool get isValidUrl {
    String url;
    final bool hasExplicitScheme = contains(RegExp(r'^[a-zA-Z]+:\/\/'));
    if (!hasExplicitScheme) {
      url = 'http://$this';
    } else {
      url = this;
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return false;
    }

    final validSchemes = ['http', 'https', 'ftp', 'ftps', 'postgres'];

    if (uri.scheme.isNotEmpty && !validSchemes.contains(uri.scheme)) {
      return false;
    }

    if (uri.host.isEmpty ||
        uri.host.startsWith('-') ||
        uri.host.endsWith('-') ||
        uri.host.contains('--')) {
      return false;
    }

    final hostSegments = uri.host.split('.');

    if (hostSegments.length < 2 ||
        hostSegments.any((segment) => segment.isEmpty)) {
      return false;
    }
    for (var segment in hostSegments) {
      if (segment.isEmpty || segment.endsWith('-') || segment.startsWith('-')) {
        return false;
      }
    }

    if (uri.hasPort && (uri.port < 0 || uri.port > 65535)) {
      return false;
    }

    if (url.contains(' ')) {
      return false;
    }

    return true;
  }
}

extension UrlPrefixer on String {
  String get ensureHttpsPrefix =>
      (startsWith('http://') || startsWith('https://'))
          ? this
          : 'https://$this';
}
