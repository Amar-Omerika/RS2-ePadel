// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      ocjena: (json['ocjena'] as num?)?.toInt(),
      terenId: (json['terenId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'ocjena': instance.ocjena,
      'terenId': instance.terenId,
    };
