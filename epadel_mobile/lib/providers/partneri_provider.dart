import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';

class PartneriProvider extends BaseProvider<Partneri> {
  PartneriProvider() : super("Partneri");

  @override
  Partneri fromJson(data) {
    return Partneri.fromJson(data);
  }
}
