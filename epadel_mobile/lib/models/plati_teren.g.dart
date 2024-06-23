// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plati_teren.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatiTeren _$PlatiTerenFromJson(Map<String, dynamic> json) => PlatiTeren(
      PlatiTerminId: (json['PlatiTerminId'] as num?)?.toInt(),
      Cijena: (json['Cijena'] as num?)?.toInt(),
      KorisnikId: (json['KorisnikId'] as num?)?.toInt(),
      TerenId: (json['TerenId'] as num?)?.toInt(),
      paymentIntentId: json['paymentIntentId'] as String?,
    );

Map<String, dynamic> _$PlatiTerenToJson(PlatiTeren instance) =>
    <String, dynamic>{
      'PlatiTerminId': instance.PlatiTerminId,
      'Cijena': instance.Cijena,
      'KorisnikId': instance.KorisnikId,
      'TerenId': instance.TerenId,
      'paymentIntentId': instance.paymentIntentId,
    };
