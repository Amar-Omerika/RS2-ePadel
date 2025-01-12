import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';

class PartneriProvider extends BaseProvider<Partneri> {
  PartneriProvider() : super("Partneri");

  @override
  Partneri fromJson(data) {
    return Partneri.fromJson(data);
  }
}
