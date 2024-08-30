import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';
import '../entities/task_entity.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;

  GetAllTasksUseCase({required this.repository});

  Future<Either<Failure , List<TaskEntity>>> call(String categoryId) async {
    return await repository.getAllTasks(categoryId);
  }
}