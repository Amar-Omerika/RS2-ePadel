import 'package:json_annotation/json_annotation.dart';

part 'teren.g.dart';

@JsonSerializable()
class Teren {
  int? terenId;
  String? naziv;
  int? brojTerena;
  int? cijena;
  int? tipTerenaId;
  String? terenNaziv;
  String? slikaTerena;

  Teren(
      {this.terenId,
      this.naziv,
      this.brojTerena,
      this.cijena,
      this.tipTerenaId,
      this.terenNaziv,
      this.slikaTerena});

  factory Teren.fromJson(Map<String, dynamic> json) => _$TerenFromJson(json);
  Map<String, dynamic> toJson() => _$TerenToJson(this);
}
