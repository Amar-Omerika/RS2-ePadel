import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/base_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

class ReportProvider extends BaseProvider<Report> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  ReportProvider() : super("Reporti"){
   _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44342/");
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Report fromJson(data) {
    return Report.fromJson(data);
  }

   Future<Report> getReporti({dynamic search}) async {
    var url = "$_baseUrl" "Reporti/reporti";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Exception... handle this gracefully");
    }
   }
}