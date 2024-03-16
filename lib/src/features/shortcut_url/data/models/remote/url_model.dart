import 'package:exception_handler/exception_handler.dart';

class UrlModel extends CustomEquatable {
  const UrlModel(this.url);
  final String url;

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(json['url']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }

  @override
  Map<String, Object?> get namedProps => {'url': url};
}
