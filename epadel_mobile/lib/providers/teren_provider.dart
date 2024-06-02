import 'package:epadel_mobile/models/teren.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class TerenProvider extends BaseProvider<Teren> {
  TerenProvider() : super("Teren");

  @override
  Teren fromJson(data) {
    return Teren.fromJson(data);
  }
}
