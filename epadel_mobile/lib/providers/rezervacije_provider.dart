import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:epadel_mobile/models/models.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';


class RezervacijaProvider extends BaseProvider<Rezervacija> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;

  RezervacijaProvider() : super("Rezervacija") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }

  @override
  Rezervacija fromJson(data) {
    return Rezervacija.fromJson(data);
  }
  Future<List<String>> getSlotsByDate([dynamic search]) async {
    var url = "$_baseUrl" + "Rezervacija/GetSlotsByDate";
    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      List<String> slots = List<String>.from(data);
      return slots;
      // return data;
    }
    return [];
  }
}
