import 'package:to_do_app/features/task/domain/entities/task_entity.dart';

abstract class TaskOperationsEvent{

  TaskOperationsEvent();
}

class AddTaskEvent extends TaskOperationsEvent{
  final TaskEntity taskEntity;

  AddTaskEvent({required this.taskEntity});
}

class DeleteTaskEvent extends TaskOperationsEvent{
  final String taskId;

  DeleteTaskEvent({required this.taskId});
}

class UpdateTaskEvent extends TaskOperationsEvent{
  final TaskEntity taskEntity;

  UpdateTaskEvent({required this.taskEntity});
}

class DoTaskEvent extends TaskOperationsEvent{
  final String taskId;
  final bool isDone;

  DoTaskEvent({required this.taskId, required this.isDone});
}