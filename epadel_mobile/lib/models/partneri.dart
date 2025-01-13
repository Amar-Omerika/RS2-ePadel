import 'package:json_annotation/json_annotation.dart';

part 'partneri.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Partneri {
  int? partnerId;
  String? naziv;
  String? deskripcija;
  String? datumObjave;

  Partneri({this.naziv, this.deskripcija, this.datumObjave});

  factory Partneri.fromJson(Map<String, dynamic> json) =>
      _$PartneriFromJson(json);
  Map<String, dynamic> toJson() => _$PartneriToJson(this);
}
