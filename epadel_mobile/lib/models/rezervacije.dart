import 'package:json_annotation/json_annotation.dart';

part 'rezervacije.g.dart';

@JsonSerializable()
class Rezervacija {
  int? korisnikId;
  int? terenId;
  String? terenNaziv;
  String? vrijemeRezervacije;
  String? datumRezervacije;
  String? paymentMethod;
  String? potrebnaReketa;
  String? korisnickoIme;
  int? cijena;
  int? brojReketa;

  Rezervacija({
    this.terenNaziv,
    this.korisnickoIme,
    this.cijena,
    this.brojReketa,
  });

  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}
