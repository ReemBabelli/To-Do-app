import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource{
  Future<String?> getUserId();
  Future<Unit> cacheTasks(List<TaskModel> taskModels , String categoryId);
  Future<List<TaskModel>> getCachedTasks(String categoryId);
}

class TaskLocalDataSourceImp extends TaskLocalDataSource{
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString('userId');
  }

  @override
  Future<Unit> cacheTasks(List<TaskModel> taskModels , String categoryId) {
    List taskToJson = taskModels
        .map<Map<String, dynamic>>((taskModel) => taskModel.toJson())
        .toList();
    sharedPreferences.setString('tasks$categoryId', jsonEncode(taskToJson));
    return Future.value(unit);
  }

  @override
  Future<List<TaskModel>> getCachedTasks(String categoryId) {
    final tasksJson = sharedPreferences.getString('tasks$categoryId');
    if (tasksJson != '[]') {
      List tasksFromJson = jsonDecode(tasksJson!);
      List<TaskModel> taskModels = tasksFromJson
          .map<TaskModel>(
              (jsonTask) => TaskModel.fromJson(jsonTask , '6550978e869786d11458'))
          .toList();
      return Future.value(taskModels);
    }else{
      throw EmptyCacheException();
    }
  }

}