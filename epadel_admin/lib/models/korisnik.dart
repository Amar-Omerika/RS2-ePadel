import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

//dart run build_runner build command to generate .g.dart files
@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? email;
  String? brTelefona;
  String? lozinka;
  String? dominantnaRuka;
  String? spol;
  String? slika;


  Korisnik(
      {this.korisnikId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.email,
      this.brTelefona,
      this.lozinka,
      this.dominantnaRuka,
      this.spol,this.slika});

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
