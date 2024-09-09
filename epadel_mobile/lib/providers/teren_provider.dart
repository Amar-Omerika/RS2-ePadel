import 'package:epadel_mobile/models/teren.dart';
import 'package:epadel_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

class TerenProvider extends BaseProvider<Teren> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;

  TerenProvider() : super("Teren") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5192/");
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }

  @override
  Teren fromJson(data) {
    return Teren.fromJson(data);
  }

   Future<List<Teren>> getTereniSaPopustom() async {
    var url = "$_baseUrl" + "Teren/tereniSaPopustom";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      List<Teren> tereni = (data as List).map((item) => Teren.fromJson(item)).toList();
      return tereni;
    }
    return [];
  }
}
