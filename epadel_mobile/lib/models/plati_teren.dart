// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'plati_teren.g.dart';

@JsonSerializable()
class PlatiTeren {
  int? PlatiTerminId;
  int? Cijena;
  int? KorisnikId;
  int? TerenId;
  String? paymentIntentId;

  PlatiTeren({
    this.PlatiTerminId,
    this.Cijena,
    this.KorisnikId,
    this.TerenId,
    this.paymentIntentId
  });

  factory PlatiTeren.fromJson(Map<String, dynamic> json) =>
      _$PlatiTerenFromJson(json);
  Map<String, dynamic> toJson() => _$PlatiTerenToJson(this);
}
