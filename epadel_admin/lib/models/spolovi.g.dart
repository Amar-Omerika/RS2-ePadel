// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spolovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spolovi _$SpoloviFromJson(Map<String, dynamic> json) => Spolovi(
      tipSpola: json['tipSpola'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpoloviToJson(Spolovi instance) => <String, dynamic>{
      'tipSpola': instance.tipSpola,
      'id': instance.id,
    };
