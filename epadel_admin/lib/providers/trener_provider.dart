import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';

class TrenerProvider extends BaseProvider<Trener> {
  TrenerProvider() : super("Trener");

  @override
  Trener fromJson(data) {
    return Trener.fromJson(data);
  }
}
