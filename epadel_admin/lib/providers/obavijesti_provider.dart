import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';

class ObavijestiProvider extends BaseProvider<Obavijesti> {
  ObavijestiProvider() : super("Obavijesti");

  @override
  Obavijesti fromJson(data) {
    return Obavijesti.fromJson(data);
  }
}
