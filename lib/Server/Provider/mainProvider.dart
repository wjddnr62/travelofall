import 'dart:convert';

import 'package:http/http.dart';

class MainProvider {
  Client _client = Client();
  final _baseUrl = "http://192.168.100.225:9090/travel_api/api/travel/";

  Future<String> getInfo(local) async {
    final response = await _client.get(
      "${_baseUrl}get-info?local=${local}"
    );

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getInfoAll() async {
    final response = await _client.get(
        "${_baseUrl}get-info-all"
    );

    return utf8.decode(response.bodyBytes);
  }
}