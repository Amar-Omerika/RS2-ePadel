import 'package:json_annotation/json_annotation.dart';

part 'spolovi.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Spolovi {
  String? tipSpola;
  int? id;

  Spolovi({this.tipSpola, this.id});

  factory Spolovi.fromJson(Map<String, dynamic> json) =>
      _$SpoloviFromJson(json);
  Map<String, dynamic> toJson() => _$SpoloviToJson(this);
}