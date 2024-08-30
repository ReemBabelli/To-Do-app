part of 'locale_cubit.dart';

@immutable
abstract class LocaleStates{}

class LocaleInitial extends LocaleStates{}

class ChangeLocaleState extends LocaleStates{
  final Locale locale;

  ChangeLocaleState({required this.locale});
}