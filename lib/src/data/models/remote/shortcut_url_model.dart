import 'package:exception_handler/exception_handler.dart';

import 'remote.dart';

class ShortcutUrlModel extends CustomEquatable {
  const ShortcutUrlModel({
    required this.alias,
    required this.links,
  });
  final String alias;
  final LinksModel links;

  factory ShortcutUrlModel.fromJson(Map<String, dynamic> json) =>
      ShortcutUrlModel(
        alias: json['alias'],
        links: LinksModel.fromJson(json['_links']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['_links'] = links.toJson();
    return data;
  }

  @override
  Map<String, Object?> get namedProps => {'alias': alias, 'links': links};
}
