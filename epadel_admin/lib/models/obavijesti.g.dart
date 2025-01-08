// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijesti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijesti _$ObavijestiFromJson(Map<String, dynamic> json) => Obavijesti(
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      datumObjave: json['datumObjave'] as String?,
    );

Map<String, dynamic> _$ObavijestiToJson(Obavijesti instance) =>
    <String, dynamic>{
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'datumObjave': instance.datumObjave,
    };
