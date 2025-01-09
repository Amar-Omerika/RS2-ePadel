import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class ObavijestiProvider extends BaseProvider<Obavijesti> {
  ObavijestiProvider() : super("Obavijesti");

  @override
  Obavijesti fromJson(data) {
    return Obavijesti.fromJson(data);
  }
}