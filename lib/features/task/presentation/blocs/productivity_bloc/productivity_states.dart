part of 'productivity_bloc.dart';

abstract class ProductivityStates {

  ProductivityStates();
}

class ProductivityInitialState extends ProductivityStates{}

class ProductivityLoadingState extends ProductivityStates{}

class ProductivityErrorState extends ProductivityStates{
  final String message;

  ProductivityErrorState({required this.message});
}

class ProductivityDataState extends ProductivityStates{
  final Map<String , double> productivity;

  ProductivityDataState({required this.productivity});
}