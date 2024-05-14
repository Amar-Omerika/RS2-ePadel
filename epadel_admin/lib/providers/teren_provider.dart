import 'package:epadel_admin/models/teren.dart';
import 'package:epadel_admin/providers/base_provider.dart';

class TerenProvider extends BaseProvider<Teren> {
  TerenProvider() : super("Teren");

  @override
  Teren fromJson(data) {
    return Teren.fromJson(data);
  }
}
