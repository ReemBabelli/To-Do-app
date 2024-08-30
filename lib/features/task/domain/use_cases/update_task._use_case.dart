import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entities/task_entity.dart';

class UpdateTaskUseCase{
  final TaskRepository repository;

  UpdateTaskUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(TaskEntity task) async {
    return await repository.updateTask(task);
  }
}