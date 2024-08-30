part of 'auth_blocs.dart';

abstract class AuthState {
  AuthState();
}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthDataState extends AuthState{
  final String message;

  AuthDataState({required this.message});

}

class AuthErrorState extends AuthState{
  final String message;

  AuthErrorState({required this.message});
}