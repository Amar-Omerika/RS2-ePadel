import 'package:epadel_mobile/models/models.dart';
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
  String? lokacija;
  int? cijena;
  int? brojReketa;
  Teren? teren;

  Rezervacija({
    this.terenNaziv,
    this.korisnickoIme,
    this.lokacija,
    this.cijena,
    this.brojReketa,
    this.teren,
  });

  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}
