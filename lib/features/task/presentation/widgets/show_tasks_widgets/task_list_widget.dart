import 'package:flutter/material.dart';
import 'package:to_do_app/features/task/presentation/widgets/show_tasks_widgets/task_widget.dart';
import '../../../domain/entities/task_entity.dart';

class TaskListWidget extends StatelessWidget {
  final List<TaskEntity> tasks;

  const TaskListWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemBuilder: (context, index) => TaskWidget(task: tasks[index]),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
        itemCount: tasks.length);
  }
}
