class TaskEntity {
  final String? userId;
  final String? categoryId;
  final String? taskId;
  final String taskName;
  final String? description;
  final String taskDate;
  final String taskTime;
  final bool isDone;

  TaskEntity(
      {this.userId,
      this.categoryId,
      this.taskId,
      required this.taskName,
      this.description,
      required this.taskDate,
      required this.taskTime,
       required this.isDone});
}
