import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class OcjeneProvider extends BaseProvider<Ocjene> {
  OcjeneProvider() : super("Ocjene");

  @override
  Ocjene fromJson(data) {
    return Ocjene.fromJson(data);
  }
}
