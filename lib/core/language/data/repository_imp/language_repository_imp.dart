import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/language/data/data_sources/language_local_data_source.dart';
import 'package:to_do_app/core/language/domain/repositories/languge_repository.dart';

class LanguageRepositoryImp extends LanguageRepository{
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImp({required this.localDataSource});
  @override
  Future<Unit> cacheLanguage(String languageCode) async {
    localDataSource.cacheLanguage(languageCode);
    return Future.value(unit);

  }

  @override
  Future<Locale> getCachedLanguage() async {
    Locale locale = await  localDataSource.getCachedLanguage();
    return locale;
  }

}