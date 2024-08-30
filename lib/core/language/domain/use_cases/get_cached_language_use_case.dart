import 'package:flutter/material.dart';
import 'package:to_do_app/core/language/domain/repositories/languge_repository.dart';

class GetCachedLanguageUseCase{
  final LanguageRepository repository;

  GetCachedLanguageUseCase({required this.repository});
  Future<Locale> call() async {
    return await repository.getCachedLanguage();
  }
}