import 'package:exception_handler/exception_handler.dart';

import 'remote.dart';

class ShortcutUrlModel extends CustomEquatable {
  const ShortcutUrlModel({
    required this.alias,
    required this.links,
  });

  factory ShortcutUrlModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'alias': final String alias,
          '_links': final Map<String, Object?> links,
        }) {
      return ShortcutUrlModel(
        alias: alias,
        links: LinksModel.fromJson(links),
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }
  final String alias;
  final LinksModel links;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['_links'] = links.toJson();
    return data;
  }

  @override
  Map<String, Object?> get namedProps => {'alias': alias, 'links': links};
}
