import 'dart:convert';

import 'package:http/http.dart';

class MainProvider {
  Client _client = Client();
  final _baseUrl = "http://api.service.oig.kr/travel_api/api/travel/";

  Future<String> getInfo(local, date) async {
    final response =
        await _client.get("${_baseUrl}get-info?local=${local}&date=${date}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getSearchInfo(local, title, date) async {
    final response =
    await _client.get("${_baseUrl}get-search-info?local=${local}&date=${date}&title=${title}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getInfoAll(date) async {
    final response = await _client.get("${_baseUrl}get-info-all?date=${date}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getSearchInfoAll(date, search) async {
    final response = await _client.get("${_baseUrl}get-search-info-all?date=${date}&title=${search}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> checkEmail(email) async {
    final response = await _client.get("${_baseUrl}check-email?email=$email");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertUser(type, email, pass, name, birthday, phone, company,
      company_number, rep_phone, site, address) async {
    final response = await _client.get(
        "${_baseUrl}insert-user?type=$type&email=$email&pass=$pass&name=$name&birthday=$birthday&phone=$phone&company=${company != null ? company : ""}&company_number=${company_number != null ? company_number : ""}&&rep_phone=${rep_phone != null ? rep_phone : ""}&site=${site != null ? site : ""}&address=${address != null ? address : ""}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> loginUser(email, pass) async {
    final response = await _client.get("${_baseUrl}login-user?email=${email}&pass=${pass}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> reviewInsert(no, idx, rating, content) async {
    final response = await _client.get("${_baseUrl}review-insert?no=$no&idx=$idx&rating=$rating&content=$content");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> reviewSelect(no, offset) async {
    final response = await _client.get("${_baseUrl}review-select?no=$no&offset=$offset");

    return utf8.decode(response.bodyBytes);
  }
}
