part of 'categories_blocs.dart';

abstract class CategoriesStates{

  CategoriesStates();
}

class CategoriesInitialState extends CategoriesStates{}

class CategoriesLoadingState extends CategoriesStates{}

class CategoriesErrorMessageState extends CategoriesStates{
  final String message;

  CategoriesErrorMessageState({required this.message});
}
class LoadedCategoriesState extends CategoriesStates{
  final List<CategoryEntity> categories;

  LoadedCategoriesState({required this.categories});
}
