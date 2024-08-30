import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/utilities/snack_bar_message.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_bloc.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_states.dart';
import '../../../../core/strings/route_names.dart';
import '../widgets/add_task_widgets/form_task_widget.dart';

class AddTaskScreen extends StatelessWidget {
  final String categoryId;
  const AddTaskScreen({super.key, required this.categoryId,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBody(context),));
  }

  _buildBody(BuildContext context) {
    return BlocConsumer<TaskOperationsBloc , TaskOperationsStates>(
        builder: (context , state){
          if(state is TaskLoadingState){
            return const LoadingWidget();
          }
          return FormTaskWidget(categoryId: categoryId);
        },
        listener: (context , state){
          if(state is TaskSuccessMessageState){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            GoRouter.of(context).goNamed(RouteNames.showTasks , pathParameters: {'categoryID':categoryId});
          } else if(state is TaskErrorMessageState){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
        }
    );
  }
}
