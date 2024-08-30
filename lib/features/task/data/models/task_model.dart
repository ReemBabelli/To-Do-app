import 'package:to_do_app/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {String? userId,
      String? categoryId,
      String? taskId,
      required String taskName,
      String? description,
      required String taskTime,
      required String taskDate,
      required bool isDone})
      : super(
            userId: userId,
            categoryId: categoryId,
            taskId: taskId,
            taskName: taskName,
            description: description,
            taskTime: taskTime,
            taskDate: taskDate,
            isDone: isDone);

  factory TaskModel.fromJson(Map<String, dynamic> json,  String? id) {
    return TaskModel(
        userId: json['userId'],
        categoryId: json['categoryId'],
        taskId: id,
        taskName: json['taskName'],
        description: json['description'],
        taskTime: json['taskTime'],
        taskDate: json['taskDate'],
        isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'categoryId': categoryId,
      'taskName': taskName,
      'description': description,
      'taskTime': taskTime,
      'taskDate': taskDate,
      'isDone': isDone
    };
  }
}
