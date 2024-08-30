import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/auth/data/models/user_model.dart';
import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/user_local_data_source.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImp(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> signIn(UserEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        UserModel userModel =
            UserModel(email: user.email, password: user.password);
        Session session = await remoteDataSource.signIn(userModel);
        localDataSource.cacheSession(session, userModel);
        return const Right(unit);
      } on UserNotFoundException {
        return Left(UserNotFoundFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(UserEntity user) async {
    UserModel userModel = UserModel(userName: user.userName,email: user.email, password: user.password);
    if (await networkInfo.isConnected) {
      try {
        Session session = await remoteDataSource.signUp(userModel);
        localDataSource.cacheSession(session, userModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<String, bool>> isLoggedIn() async {
    try {
      bool isLoggedIn = await localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
   if(await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout();
        localDataSource.logout();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
     return Left(OffLineFailure());
   }
  }
}
