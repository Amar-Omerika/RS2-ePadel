import 'package:epadel_mobile/models/tip_terena.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teren.g.dart';

@JsonSerializable()
class Teren {
  int? terenId;
  String? naziv;
  int? brojTerena;
  int? cijena;
  int? tipTerenaId;
  String? slikaTerena;
  String? lokacija;
  String? popust;
  int? cijenaPopusta;
  TipTerena? tipTerena;

  Teren(
      {this.terenId,
      this.naziv,
      this.brojTerena,
      this.cijena,
      this.tipTerenaId,
      this.slikaTerena,
      this.tipTerena,
      this.lokacija,
      this.popust,
      this.cijenaPopusta});

  factory Teren.fromJson(Map<String, dynamic> json) => _$TerenFromJson(json);
  Map<String, dynamic> toJson() => _$TerenToJson(this);
}
