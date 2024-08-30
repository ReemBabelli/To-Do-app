import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../domain/use_cases/cache_language_use_case.dart';
import '../domain/use_cases/get_cached_language_use_case.dart';

part 'locale_states.dart';

class LocaleCubit extends Cubit<LocaleStates>{
  final GetCachedLanguageUseCase getCachedLanguage;
  final CacheLanguageUseCase cacheLanguage;
  LocaleCubit({required this.getCachedLanguage,required this.cacheLanguage}): super(LocaleInitial());

  Future<Unit> getSavedLanguage() async {
    final Locale locale = await getCachedLanguage();
    emit(ChangeLocaleState(locale:locale));
    return unit;
  }

  Future<Unit> changeLanguage(String languageCode) async {
    Locale locale;
    await cacheLanguage(languageCode);
    if(languageCode == 'ar'){
      locale = AppLocalizations.supportedLocales[0];
    }else{
      locale = AppLocalizations.supportedLocales[1];
    }
    emit(ChangeLocaleState(locale: locale));
    return Future.value(unit);
  }
}