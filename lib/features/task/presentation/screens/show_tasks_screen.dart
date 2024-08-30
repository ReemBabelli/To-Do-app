import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_bloc.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_events.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_states.dart';
import '../../../../core/strings/route_names.dart';
import '../../../../core/widgets/error_message_widget.dart';
import '../../../../core/utilities/injection_container.dart' as di;
import '../widgets/show_tasks_widgets/task_list_widget.dart';


class ShowTasksScreen extends StatefulWidget {
  final String categoryId;

  const ShowTasksScreen({super.key, required this.categoryId});

  @override
  State<ShowTasksScreen> createState() => _ShowTasksScreenState();
}

class _ShowTasksScreenState extends State<ShowTasksScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<TasksBloc>().add(GetAllTasksEvent(categoryId: widget.categoryId));
    return SafeArea(
        child: Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    ));
  }


  _buildBody() {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const LoadingWidget();
        } else if (state is TasksErrorMessageState) {
          return ErrorMessageWidget(message: state.message);
        } else if (state is LoadedTasksState) {
          return TaskListWidget(
            tasks: state.tasks,
          );
        }
        return const SizedBox();
      },
    );
  }

  _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (cx) {
        //   return Provider(
        //       child: const AddTaskScreen(), create: (cx) => widget.categoryId);
        // }));
        GoRouter.of(context).goNamed(RouteNames.addTask , pathParameters: {'categoryID':widget.categoryId});
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
