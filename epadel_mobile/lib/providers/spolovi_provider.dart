import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class SpoloviProvider extends BaseProvider<Spolovi> {
  SpoloviProvider() : super("Spolovi");

  @override
  Spolovi fromJson(data) {
    return Spolovi.fromJson(data);
  }
}
