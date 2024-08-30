abstract class TasksEvent{

  TasksEvent();
}

class GetAllTasksEvent extends TasksEvent{
  final String categoryId;

  GetAllTasksEvent({required this.categoryId});
}

class GetTodayTasksEvent extends TasksEvent{

}