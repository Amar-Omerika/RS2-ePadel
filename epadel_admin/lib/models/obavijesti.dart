import 'package:json_annotation/json_annotation.dart';

part 'obavijesti.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Obavijesti {
  int? obavijestId;
  String? naslov;
  String? sadrzaj;
  String? datumObjave;

  Obavijesti({this.naslov, this.sadrzaj, this.datumObjave});

  factory Obavijesti.fromJson(Map<String, dynamic> json) =>
      _$ObavijestiFromJson(json);
  Map<String, dynamic> toJson() => _$ObavijestiToJson(this);
}
