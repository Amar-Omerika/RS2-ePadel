// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trener.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trener _$TrenerFromJson(Map<String, dynamic> json) => Trener(
      trenerId: (json['trenerId'] as num?)?.toInt(),
      imePrezime: json['imePrezime'] as String?,
      bio: json['bio'] as String?,
      kontaktTel: json['kontaktTel'] as String?,
    );

Map<String, dynamic> _$TrenerToJson(Trener instance) => <String, dynamic>{
      'trenerId': instance.trenerId,
      'imePrezime': instance.imePrezime,
      'bio': instance.bio,
      'kontaktTel': instance.kontaktTel,
    };
