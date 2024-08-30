import '../../../domain/entities/task_entity.dart';

abstract class TasksStates{

  TasksStates();
}

class TasksInitialState extends TasksStates{}

class TasksLoadingState extends TasksStates{}

class TasksErrorMessageState extends TasksStates{
  final String message;

  TasksErrorMessageState({required this.message});
}
class LoadedTasksState extends TasksStates{
  final List<TaskEntity> tasks;

  LoadedTasksState({required this.tasks});
}