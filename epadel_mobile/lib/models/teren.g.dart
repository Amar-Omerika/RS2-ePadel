// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teren.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teren _$TerenFromJson(Map<String, dynamic> json) => Teren(
      terenId: (json['terenId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      brojTerena: (json['brojTerena'] as num?)?.toInt(),
      cijena: (json['cijena'] as num?)?.toInt(),
      tipTerenaId: (json['tipTerenaId'] as num?)?.toInt(),
      slikaTerena: json['slikaTerena'] as String?,
      tipTerena: json['tipTerena'] == null
          ? null
          : TipTerena.fromJson(json['tipTerena'] as Map<String, dynamic>),
      lokacija: json['lokacija'] as String?,
      popust: json['popust'] as String?,
      cijenaPopusta: (json['cijenaPopusta'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TerenToJson(Teren instance) => <String, dynamic>{
      'terenId': instance.terenId,
      'naziv': instance.naziv,
      'brojTerena': instance.brojTerena,
      'cijena': instance.cijena,
      'tipTerenaId': instance.tipTerenaId,
      'slikaTerena': instance.slikaTerena,
      'lokacija': instance.lokacija,
      'popust': instance.popust,
      'cijenaPopusta': instance.cijenaPopusta,
      'tipTerena': instance.tipTerena,
    };
