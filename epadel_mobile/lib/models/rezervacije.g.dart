// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      terenNaziv: json['terenNaziv'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      cijena: (json['cijena'] as num?)?.toInt(),
      brojReketa: (json['brojReketa'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..terenId = (json['terenId'] as num?)?.toInt()
      ..vrijemeRezervacije = json['vrijemeRezervacije'] as String?
      ..datumRezervacije = json['datumRezervacije'] as String?
      ..paymentMethod = json['paymentMethod'] as String?
      ..potrebnaReketa = json['potrebnaReketa'] as String?;

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'terenId': instance.terenId,
      'terenNaziv': instance.terenNaziv,
      'vrijemeRezervacije': instance.vrijemeRezervacije,
      'datumRezervacije': instance.datumRezervacije,
      'paymentMethod': instance.paymentMethod,
      'potrebnaReketa': instance.potrebnaReketa,
      'korisnickoIme': instance.korisnickoIme,
      'cijena': instance.cijena,
      'brojReketa': instance.brojReketa,
    };
