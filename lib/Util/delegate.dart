import 'package:flutter/cupertino.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Util/translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ko', 'en', 'ja', 'zh-chs'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    Translations localizations = Translations();
    await localizations.load();

    print("Load ${mainBloc.locale}");

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;


}