import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';

class TrenerProvider extends BaseProvider<Trener> {
  TrenerProvider() : super("Trener");

  @override
  Trener fromJson(data) {
    return Trener.fromJson(data);
  }
}
