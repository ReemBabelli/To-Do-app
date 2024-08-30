part of 'category_operations_blocs.dart';

abstract class CategoryOperationsStates{

  CategoryOperationsStates();
}

class CategoryInitialState extends CategoryOperationsStates{}

class CategoryLoadingState extends CategoryOperationsStates{}

class CategorySuccessMessageState extends CategoryOperationsStates{
  final String message;

  CategorySuccessMessageState({required this.message});
}

class CategoryErrorMessageState extends CategoryOperationsStates{
  final String message;

  CategoryErrorMessageState({required this.message});
}