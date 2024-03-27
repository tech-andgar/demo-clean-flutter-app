import 'package:exception_handler/exception_handler.dart';

class LinksModel extends CustomEquatable {
  const LinksModel({
    required this.self,
    required this.short,
  });

  factory LinksModel.fromJson(final Map<String, Object?> json) {
    if (json
        case {
          'self': final String self,
          'short': final String short,
        }) {
      return LinksModel(self: self, short: short);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  final String self;
  final String short;

  @override
  Map<String, Object?> get namedProps =>
      <String, Object?>{'self': self, 'short': short};

  Map<String, Object?> toJson() {
    final Map<String, Object?> data = <String, Object?>{};
    data['self'] = self;
    data['short'] = short;

    return data;
  }
}
