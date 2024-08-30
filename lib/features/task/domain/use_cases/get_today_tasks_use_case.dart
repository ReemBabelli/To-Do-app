import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';

class GetTodayTasksUseCase {
  final TaskRepository repository;

  GetTodayTasksUseCase({required this.repository});

  Future<Either<Failure , List<TaskEntity>>> call() async{
    return await repository.getTodayTasks();
  }
}