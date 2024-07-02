import 'package:json_annotation/json_annotation.dart';

part 'ocjene.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Ocjene {
  int? ocjena;
  int? terenId;

  Ocjene({this.ocjena, this.terenId});

  factory Ocjene.fromJson(Map<String, dynamic> json) =>
      _$OcjeneFromJson(json);
  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}