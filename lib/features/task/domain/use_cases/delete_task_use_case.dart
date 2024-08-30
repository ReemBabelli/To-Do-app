import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';

import '../../../../core/errors/failures.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(String taskId) async {
    return await repository.deleteTask(taskId);
  }
}