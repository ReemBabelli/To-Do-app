import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({ super.userName,required super.email, required super.password});

  factory UserModel.fromJson(Map<String , dynamic> json){
    return UserModel(userName: json['name'] , email: json['email'] , password: json['password']);
  }

  Map<String , dynamic> toJson(){
    return {
      'name': userName,
      'email':email,
      'password': password
    };
  }

}