import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/error_message_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/utilities/injection_container.dart' as di;
import '../blocs/Tasks_bloc/tasks_bloc.dart';
import '../blocs/Tasks_bloc/tasks_events.dart';
import '../blocs/Tasks_bloc/tasks_states.dart';
import '../widgets/show_tasks_widgets/task_list_widget.dart';

class ShowTodayTasksScreen extends StatelessWidget {

  const ShowTodayTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      di.sl<TasksBloc>()
        ..add(GetTodayTasksEvent()),
      child: SafeArea(
          child: Scaffold(
           // appBar: _buildAppBar(context),
            body: _buildBody(),
          )
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const LoadingWidget();
        } else if (state is TasksErrorMessageState) {
          return ErrorMessageWidget(message: state.message);
        } else if (state is LoadedTasksState) {
          return TaskListWidget(tasks: state.tasks,);
        }
        return const SizedBox();
      },
    );
  }

}
