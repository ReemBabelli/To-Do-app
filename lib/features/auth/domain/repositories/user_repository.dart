import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class UserRepository{
  Future<Either<Failure,Unit>> signIn(UserEntity user);
  Future<Either<Failure,Unit>> signUp(UserEntity user);
  Future<Either<Failure , Unit>> logout();
  Future<Either<String,bool>> isLoggedIn();

}