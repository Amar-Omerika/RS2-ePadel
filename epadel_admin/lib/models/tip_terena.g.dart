// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_terena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipTerena _$TipTerenaFromJson(Map<String, dynamic> json) => TipTerena(
      tipTerenaId: (json['tipTerenaId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      slika: json['slika'] as String?,
    );

Map<String, dynamic> _$TipTerenaToJson(TipTerena instance) => <String, dynamic>{
      'tipTerenaId': instance.tipTerenaId,
      'naziv': instance.naziv,
      'slika': instance.slika,
    };
