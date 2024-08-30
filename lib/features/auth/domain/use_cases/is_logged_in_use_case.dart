import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';

class IsLoggedInUseCase{
  final UserRepository repository;

  IsLoggedInUseCase({required this.repository});

  Future<Either<String,bool>> call() async{
    return await repository.isLoggedIn();
  }
}