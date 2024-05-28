import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/lang_model.dart';


class AppLocalizations {
  final Locale locale;
  LangModel? _localizeLangModel;

  AppLocalizations(this.locale);



  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /*late Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/translations_en.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap[locale.languageCode];
    return true;
  }

  List<String> get greetings {
    return List<String>.from(_localizedStrings['greetings']);
  }*/

  Future<bool> load() async {

    String languageCode = locale.languageCode;
   // String assetPath = 'assets/translations_$languageCode.json';
    String assetPath = 'assets/lang_file/${languageCode}_local.json';

    String jsonString = await rootBundle.loadString(assetPath);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizeLangModel = LangModel.fromJson(jsonMap[locale.languageCode]);
    return true;
  }

  LangModel? get localizeLangModel => _localizeLangModel;


}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}