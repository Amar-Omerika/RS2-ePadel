// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partneri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partneri _$PartneriFromJson(Map<String, dynamic> json) => Partneri(
      naziv: json['naziv'] as String?,
      deskripcija: json['deskripcija'] as String?,
      datumObjave: json['datumObjave'] as String?,
    )..partnerId = (json['partnerId'] as num?)?.toInt();

Map<String, dynamic> _$PartneriToJson(Partneri instance) => <String, dynamic>{
      'partnerId': instance.partnerId,
      'naziv': instance.naziv,
      'deskripcija': instance.deskripcija,
      'datumObjave': instance.datumObjave,
    };
