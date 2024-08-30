import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';

class SignInUseCase {
  final UserRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(UserEntity user)async{
    return await repository.signIn(user);
  }
}