import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/models/tip_terena.dart';
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
  Gradovi? gradovi;

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
      this.cijenaPopusta,this.gradovi});

  factory Teren.fromJson(Map<String, dynamic> json) => _$TerenFromJson(json);
  Map<String, dynamic> toJson() => _$TerenToJson(this);
}
