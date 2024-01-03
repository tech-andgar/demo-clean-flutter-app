import 'package:exception_handler/exception_handler.dart';

class LinksModel extends CustomEquatable {
  const LinksModel({
    required this.self,
    required this.short,
  });
  final String self;
  final String short;

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      LinksModel(self: json['self'], short: json['short']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['short'] = short;
    return data;
  }

  @override
  Map<String, Object?> get namedProps => {'self': self, 'short': short};
}
