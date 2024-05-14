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
      terenNaziv: json['terenNaziv'] as String?,
      slikaTerena: json['slikaTerena'] as String?,
    );

Map<String, dynamic> _$TerenToJson(Teren instance) => <String, dynamic>{
      'terenId': instance.terenId,
      'naziv': instance.naziv,
      'brojTerena': instance.brojTerena,
      'cijena': instance.cijena,
      'tipTerenaId': instance.tipTerenaId,
      'terenNaziv': instance.terenNaziv,
      'slikaTerena': instance.slikaTerena,
    };
