import 'package:json_annotation/json_annotation.dart';

part 'trener.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Trener {
  int? trenerId;
  String? imePrezime;
  String? bio;
  String? kontaktTel;

  Trener({this.trenerId,this.imePrezime, this.bio, this.kontaktTel});

  factory Trener.fromJson(Map<String, dynamic> json) =>
      _$TrenerFromJson(json);
  Map<String, dynamic> toJson() => _$TrenerToJson(this);
}
