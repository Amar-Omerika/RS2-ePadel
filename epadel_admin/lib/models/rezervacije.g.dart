// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      rezervacijaId: (json['rezervacijaId'] as num?)?.toInt(),
      terenNaziv: json['terenNaziv'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      cijena: (json['cijena'] as num?)?.toInt(),
      brojReketa: (json['brojReketa'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'terenNaziv': instance.terenNaziv,
      'korisnickoIme': instance.korisnickoIme,
      'cijena': instance.cijena,
      'brojReketa': instance.brojReketa,
    };
