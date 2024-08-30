part of 'auth_blocs.dart';

abstract class AuthEvent {
  AuthEvent();
}

class SignInEvent extends AuthEvent{
  final UserEntity user;

  SignInEvent({required this.user});
}

class SignUpEvent  extends AuthEvent{
  final UserEntity user;

  SignUpEvent({required this.user});
}

class LogoutEvent extends AuthEvent{

}
