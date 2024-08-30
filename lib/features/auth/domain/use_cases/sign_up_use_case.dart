import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure , Unit>> call (UserEntity user)async => await repository.signUp(user);

}