import 'package:json_annotation/json_annotation.dart';

part 'reporti.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Report {
  int? ukupnaZaradaTerena;
  int? brojRezervacijeTerena;
  int? ukupanBrojKorisnika;
  int? ukupnaZaradaSistema;
  int? korisnikId;


  Report({this.ukupnaZaradaTerena, this.brojRezervacijeTerena,this.ukupanBrojKorisnika});

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}