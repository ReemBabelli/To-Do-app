import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:to_do_app/features/task/data/models/task_model.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';

import '../../../../core/network/network_info.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class TaskRepositoryImp implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImp(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    final userId = await localDataSource.getUserId() ?? '';
    final TaskModel taskModel = TaskModel(
        userId: userId,
        categoryId: task.categoryId,
        taskName: task.taskName,
        description: task.description,
        taskTime: task.taskTime,
        taskDate: task.taskDate,
        isDone: task.isDone);
    return await _getMessage(() => remoteDataSource.addTask(taskModel));
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String taskId) async {
    return await _getMessage(() => remoteDataSource.deleteTask(taskId));
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskEntity task) async {
    TaskModel taskModel = TaskModel(
        taskId: task.taskId,
        categoryId: task.categoryId,
        userId: task.userId,
        taskName: task.taskName,
        description: task.description,
        taskTime: task.taskTime,
        taskDate: task.taskDate,
        isDone: task.isDone);
    return await _getMessage(() => remoteDataSource.updateTask(taskModel));
  }

  @override
  Future<Either<Failure, Unit>> doTask(String taskId, bool isDone) async {
    return await _getMessage(() => remoteDataSource.doTask(taskId, isDone));
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(
      String categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        List<TaskModel> taskModels =
            await remoteDataSource.getAllTasks(categoryId);
        localDataSource.cacheTasks(taskModels, categoryId);
        return Right(taskModels);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    } else {
      try {
        List<TaskModel> tasks =
            await localDataSource.getCachedTasks(categoryId);
        return Right(tasks);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTodayTasks() async {
    try {
      final userId = await localDataSource.getUserId() ?? '';
      List<TaskModel> taskModels = await remoteDataSource.getTodayTasks(userId);
      return Right(taskModels);
    } on ServerException {
      return Left(ServerFailure());
    }on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<String, Map<String, double>>> showProductivity() async {
    try {
      final userId = await localDataSource.getUserId() ?? '';
      double productivityToday =
          await remoteDataSource.showTodayProductivity(userId);
      double productivityThisMonth =
          await remoteDataSource.showProductivityOfTheMonth(userId);
      Map<String, double> productivity = {
        'productivityToday': productivityToday,
        'productivityThisMonth': productivityThisMonth
      };
      return Right(productivity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
