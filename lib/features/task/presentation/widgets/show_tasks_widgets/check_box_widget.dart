import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/Tasks_bloc/tasks_bloc.dart';
import '../../blocs/Tasks_bloc/tasks_events.dart';
import '../../blocs/task_operations_bloc/task_operations_bloc.dart';
import '../../blocs/task_operations_bloc/task_operations_events.dart';

class CheckboxWidget extends StatelessWidget {
  final String taskId;
  final String categoryId;
  final bool isDone;
  const CheckboxWidget({super.key, required this.taskId, required this.isDone, required this.categoryId});

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.amber;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isDone,
      onChanged: (bool? value) {
        BlocProvider.of<TaskOperationsBloc>(context).add(DoTaskEvent(
            taskId: taskId, isDone: value! ));

      },
    );
  }
}
