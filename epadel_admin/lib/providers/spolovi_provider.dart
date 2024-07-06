

import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';

class SpoloviProvider extends BaseProvider<Spolovi> {
  SpoloviProvider() : super("Spolovi");

  @override
  Spolovi fromJson(data) {
    return Spolovi.fromJson(data);
  }
}