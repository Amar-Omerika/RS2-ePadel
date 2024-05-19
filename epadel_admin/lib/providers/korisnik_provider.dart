import 'package:epadel_admin/models/korisnik.dart';
import 'package:epadel_admin/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }
}
