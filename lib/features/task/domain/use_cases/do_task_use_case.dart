import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';

import '../../../../core/errors/failures.dart';

class DoTaskUseCase {
  final TaskRepository repository;

  DoTaskUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(String taskId, bool isDone) async{
    return await repository.doTask(taskId, isDone);
  }
}