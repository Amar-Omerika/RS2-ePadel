// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reporti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      ukupnaZaradaTerena: (json['ukupnaZaradaTerena'] as num?)?.toInt(),
      brojRezervacijeTerena: (json['brojRezervacijeTerena'] as num?)?.toInt(),
      ukupanBrojKorisnika: (json['ukupanBrojKorisnika'] as num?)?.toInt(),
    )
      ..ukupnaZaradaSistema = (json['ukupnaZaradaSistema'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt();

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'ukupnaZaradaTerena': instance.ukupnaZaradaTerena,
      'brojRezervacijeTerena': instance.brojRezervacijeTerena,
      'ukupanBrojKorisnika': instance.ukupanBrojKorisnika,
      'ukupnaZaradaSistema': instance.ukupnaZaradaSistema,
      'korisnikId': instance.korisnikId,
    };
