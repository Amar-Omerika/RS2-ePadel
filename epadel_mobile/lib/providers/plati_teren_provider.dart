import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class PlatiTerenProvider extends BaseProvider<PlatiTeren> {
  PlatiTerenProvider() : super("PlatiTermin");

  @override
  PlatiTeren fromJson(data) {
    return PlatiTeren.fromJson(data);
  }
}
