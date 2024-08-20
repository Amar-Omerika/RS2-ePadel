import 'package:epadel_admin/models/tip_terena.dart';
import 'package:epadel_admin/providers/base_provider.dart';

class TipTerenaProvider extends BaseProvider<TipTerena> {
  TipTerenaProvider() : super("TipTerena");

  get tipTerenaId => null;

  @override
  TipTerena fromJson(data) {
    return TipTerena.fromJson(data);
  }
}
