import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_bloc.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_events.dart';
import 'package:to_do_app/features/task/presentation/widgets/show_tasks_widgets/check_box_widget.dart';
import 'package:to_do_app/features/task/presentation/widgets/show_tasks_widgets/delete_dialog_widget.dart';
import 'package:to_do_app/features/task/presentation/widgets/show_tasks_widgets/update_dialog_widget.dart';
import '../../../../../core/utilities/snack_bar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/utilities/styles.dart';
import '../../blocs/task_operations_bloc/task_operations_bloc.dart';
import '../../blocs/task_operations_bloc/task_operations_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
     List<String> list = <String>[AppLocalizations.of(context)!.edit, AppLocalizations.of(context)!.delete];
    return InkWell(
      child: Card(
        elevation: 3.0,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
                title: Text(
                  task.taskName,
                  style: getBlueGreyTitle(context),
                ),
                subtitle: Text(
                  task.description ?? '',
                  style: getBlackText(context),
                ),
                leading: _buildBox(),
                trailing: Column(
                  children: [
                    Text(
                      task.taskDate,
                      style: getBlackText(context),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      task.taskTime,
                      style: getBlackText(context),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  icon: const Icon(Icons.more_horiz),
                  style: const TextStyle(color: Colors.blueGrey),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    if (value == list[1]) {
                      _deleteDialog(context);
                    } else {
                      _updateDialog(context);
                    }
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<TaskOperationsBloc, TaskOperationsStates>(
              builder: (context, state) {
            if (state is TaskLoadingState) {
              return const AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(taskId: task.taskId);
          }, listener: (context, state) {
            if (state is TaskSuccessMessageState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent(categoryId: task.categoryId!));
              Navigator.of(context).pop();

            } else if (state is TaskErrorMessageState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          });
        });
  }

  void _updateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<TaskOperationsBloc, TaskOperationsStates>(
              builder: (context, state) {
            if (state is TaskLoadingState) {
              return const AlertDialog(title: LoadingWidget());
            }
            return UpdateDialogWidget(
              task: task,
            );
          }, listener: (context, state) {
            if (state is TaskSuccessMessageState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent(categoryId: task.categoryId!));
              Navigator.of(context).pop();
            } else if (state is TaskErrorMessageState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          });
        });
  }

  _buildBox() {
    return BlocConsumer<TaskOperationsBloc, TaskOperationsStates>(
      builder: (context, state) {
        return CheckboxWidget(
            taskId: task.taskId!,
            isDone: task.isDone,
            categoryId: task.categoryId!);
      },
      listener: (context, state) {
        if (state is TaskSuccessMessageState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent(categoryId: task.categoryId!));
        } else if (state is TaskErrorMessageState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
    );
  }
}
