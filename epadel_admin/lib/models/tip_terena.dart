import 'package:json_annotation/json_annotation.dart';

part 'tip_terena.g.dart';

@JsonSerializable()
class TipTerena {
  int? tipTerenaId;
  String? naziv;
  String? slika;

  TipTerena({this.tipTerenaId, this.naziv, this.slika});

  factory TipTerena.fromJson(Map<String, dynamic> json) =>
      _$TipTerenaFromJson(json);
  Map<String, dynamic> toJson() => _$TipTerenaToJson(this);
}
