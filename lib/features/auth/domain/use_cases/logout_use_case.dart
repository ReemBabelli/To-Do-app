import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';

class LogoutUseCase{
  final UserRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure , Unit>> call()async{
    return await repository.logout();
  }
}