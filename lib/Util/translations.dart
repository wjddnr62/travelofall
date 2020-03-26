import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';

class Translations {
//  final Locale locale;
//
//  Translations(this.locale);

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {

    print('load');
    String data = await rootBundle
        .loadString("assets/locale/${mainBloc.locale}.json");

    Map<String, dynamic> _result = json.decode(data);

    this._sentences = Map();
    _result.forEach((key, value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return this._sentences[key];
  }

}
