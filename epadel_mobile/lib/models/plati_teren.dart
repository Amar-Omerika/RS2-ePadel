import 'package:json_annotation/json_annotation.dart';

part 'plati_teren.g.dart';

@JsonSerializable()
class PlatiTeren {
  int? PlatiTerminId;
  int? Cijena;
  int? KorisnikId;
  int? TerenId;

  PlatiTeren({
    this.PlatiTerminId,
    this.Cijena,
    this.KorisnikId,
    this.TerenId,
  });

  factory PlatiTeren.fromJson(Map<String, dynamic> json) =>
      _$PlatiTerenFromJson(json);
  Map<String, dynamic> toJson() => _$PlatiTerenToJson(this);
}
