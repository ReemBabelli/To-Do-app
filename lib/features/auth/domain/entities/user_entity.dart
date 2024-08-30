class UserEntity{
  final int? userId;
  final String? userName;
  final String email;
  final String password;

  UserEntity({this.userId , this.userName, required this.email, required this.password});
}