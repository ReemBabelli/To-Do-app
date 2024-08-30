import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/language/domain/repositories/languge_repository.dart';

class CacheLanguageUseCase{
  final LanguageRepository repository;

  CacheLanguageUseCase({required this.repository});

  Future<Unit> call(String languageCode) async {
    return await repository.cacheLanguage(languageCode);
  }
}