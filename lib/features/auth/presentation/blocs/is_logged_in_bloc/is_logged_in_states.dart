part of 'is_logged_in_bloc.dart';

abstract class IsLoggedInState {
  IsLoggedInState();
}

class IsLoggedInInitialState extends IsLoggedInState{}

class IsLoggedInDataState extends IsLoggedInState{
  final bool isLoggedIn;

  IsLoggedInDataState({required this.isLoggedIn});


}

class IsLoggedInErrorState extends IsLoggedInState{
  final String message;

  IsLoggedInErrorState({required this.message});

}