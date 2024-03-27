import 'package:exception_handler/exception_handler.dart';

class UrlModel extends CustomEquatable {
  const UrlModel(this.url);

  factory UrlModel.fromJson(final Map<String, dynamic> json) {
    if (json case {'url': final String url}) {
      return UrlModel(url);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  final String url;

  @override
  Map<String, Object?> get namedProps => <String, Object?>{'url': url};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;

    return data;
  }
}
