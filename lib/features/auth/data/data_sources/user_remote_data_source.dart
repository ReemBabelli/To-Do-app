import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/auth/data/models/user_model.dart';
import '../../../../main.dart';

abstract class UserRemoteDataSource {
  Future<Session> signIn(UserModel user);
  Future<Session> signUp(UserModel user);
  Future<Unit> logout();
}

class UserRemoteDataSourceImp implements UserRemoteDataSource{

  final account = Account(client);


  @override
  Future<Session> signIn(UserModel userModel) async {
    try{
      final Session response = await account.createEmailSession(email: userModel.email, password: userModel.password);
      return response;
    }catch(e){
      throw UserNotFoundException();
    }
  }

  @override
  Future<Session> signUp(UserModel userModel) async {
    try{
      await account.create(userId: ID.unique(),name: userModel.userName, email: userModel.email, password: userModel.password);
      final Session response = await signIn(userModel);
      return response;
    }catch(e){
      throw ServerException();
    }
  }

  @override
  Future<Unit> logout() async {
    try{
      await account.deleteSessions();
      return unit;
    }catch(e){
      throw ServerException();
    }
  }

}