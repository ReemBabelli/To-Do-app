import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';

abstract class TaskRepository{
  Future<Either<Failure , Unit>> addTask(TaskEntity task);
  Future<Either<Failure , Unit>> updateTask(TaskEntity task);
  Future<Either<Failure , Unit>> doTask(String taskId, bool isDone);
  Future<Either<Failure , Unit>> deleteTask(String taskId);
  Future<Either<Failure , List<TaskEntity>>> getAllTasks(String categoryId);
  Future<Either<Failure , List<TaskEntity>>> getTodayTasks();
  Future<Either<String , Map<String,double>>> showProductivity();

}