import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/task_operations_bloc/task_operations_bloc.dart';
import '../../blocs/task_operations_bloc/task_operations_events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String? taskId;

  const DeleteDialogWidget({super.key, this.taskId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(AppLocalizations.of(context)!.areYouSure),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text(AppLocalizations.of(context)!.no)),
        TextButton(
            onPressed: () {
              BlocProvider.of<TaskOperationsBloc>(context)
                  .add(DeleteTaskEvent(taskId: taskId!));
            },
            child:  Text(AppLocalizations.of(context)!.yes)),
      ],

    );
  }
}
