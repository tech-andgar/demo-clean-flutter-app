/// Extension method for the String class to validate URL strings.
extension UrlValidator on String {
  /// Checks whether the string represents a valid URL.
  ///
  /// Returns true if the string is a valid URL, otherwise returns false.
  bool get isValidUrl {
    String url;
    final bool hasExplicitScheme = contains(RegExp(r'^[a-zA-Z]+:\/\/'));

    // Adding 'http://' prefix if no explicit scheme is provided.
    url = (!hasExplicitScheme) ? 'http://$this' : this;

    Uri? uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return false;
    }

    // List of valid URL schemes.
    final List<String> validSchemes = <String>[
      'http',
      'https',
      'ftp',
      'ftps',
      'postgres',
    ];

    // Checking scheme validity.
    if (uri.scheme.isNotEmpty && !validSchemes.contains(uri.scheme)) {
      return false;
    }

    // Checking host validity.
    if (uri.host.isEmpty ||
        uri.host.startsWith('-') ||
        uri.host.endsWith('-') ||
        uri.host.contains('--')) {
      return false;
    }

    // Checking host segments validity.
    final List<String> hostSegments = uri.host.split('.');
    if (hostSegments.length < 2 ||
        hostSegments.any((final String segment) => segment.isEmpty)) {
      return false;
    }
    for (final String segment in hostSegments) {
      if (segment.isEmpty || segment.endsWith('-') || segment.startsWith('-')) {
        return false;
      }
    }

    // Checking port validity.
    if (uri.hasPort && (uri.port < 0 || uri.port > 65535)) {
      return false;
    }

    // Checking for spaces in the URL.
    if (url.contains(' ')) {
      return false;
    }

    return true;
  }
}

/// Extension method for the String class to ensure that a URL has
/// an 'https://' prefix.
extension UrlPrefixer on String {
  /// Ensures that the URL string has an 'https://' prefix.
  ///
  /// If the URL already starts with 'http://' or 'https://',
  /// it returns the original URL.
  /// Otherwise, it adds 'https://' prefix to the URL.
  ///
  /// Example:
  /// ```dart
  /// // Example URL strings
  /// const String url1 = 'example.com';
  /// const String url2 = 'http://example.com';
  /// const String url3 = 'https://example.com';
  ///
  /// // Applying the extension method to ensure 'https://' prefix
  /// final String secureUrl1 = url1.ensureHttpsPrefix;
  /// final String secureUrl2 = url2.ensureHttpsPrefix;
  /// final String secureUrl3 = url3.ensureHttpsPrefix;
  ///
  /// // Printing the original and secured URLs
  /// print('Original URL 1: $url1');
  /// print('Secured URL 1: $secureUrl1'); // Output: https://example.com
  ///
  /// print('Original URL 2: $url2');
  /// print('Secured URL 2: $secureUrl2');
  /// // Output: http://example.com (no change)
  ///
  /// print('Original URL 3: $url3');
  /// print('Secured URL 3: $secureUrl3');
  /// // Output: https://example.com (no change)
  /// ```
  String get ensureHttpsPrefix =>
      (startsWith('http://') || startsWith('https://'))
          ? this
          : 'https://$this';
}
