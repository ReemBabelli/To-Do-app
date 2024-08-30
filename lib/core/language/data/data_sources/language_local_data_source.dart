import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LanguageLocalDataSource{
  Future<Unit> cacheLanguage(String languageCode);
  Future<Locale> getCachedLanguage();
}

class LanguageLocalDataSourceImp extends LanguageLocalDataSource{
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cacheLanguage(String languageCode) async {
    await sharedPreferences.setString('Locale', languageCode);
    return Future.value(unit);
  }

  @override
  Future<Locale> getCachedLanguage()  {
    Locale locale;
    String? languageCode = sharedPreferences.getString('Locale');
    if(languageCode == 'ar'){
       locale = AppLocalizations.supportedLocales[0];
    }else{
      locale = AppLocalizations.supportedLocales[1];
    }
    return Future.value(locale);
  }

}