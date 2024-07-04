import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';

class GradoviProvider extends BaseProvider<Gradovi> {
  GradoviProvider() : super("Gradovi");

  @override
  Gradovi fromJson(data) {
    return Gradovi.fromJson(data);
  }
}