import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class LanguageRepository{
  Future<Unit> cacheLanguage(String languageCode);
  Future<Locale> getCachedLanguage();
}