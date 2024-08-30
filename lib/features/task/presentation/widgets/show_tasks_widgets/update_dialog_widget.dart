import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/widgets/textField_widget.dart';
import '../../blocs/task_operations_bloc/task_operations_bloc.dart';
import '../../blocs/task_operations_bloc/task_operations_events.dart';


class UpdateDialogWidget extends StatefulWidget {
  final TaskEntity task;

  const UpdateDialogWidget({super.key, required this.task});

  @override
  State<UpdateDialogWidget> createState() => _UpdateDialogWidgetState();
}

class _UpdateDialogWidgetState extends State<UpdateDialogWidget> {
  TextEditingController taskCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();

  @override
  void initState() {
    taskCont.text = widget.task.taskName;
    descriptionCont.text = widget.task.description ?? '';
    dateCont.text = widget.task.taskDate.toString();
    timeCont.text = widget.task.taskTime;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
        title: Text(AppLocalizations.of(context)!.editTask),
        content: Column(
          children: [
            TextFieldWidget(
                defText: AppLocalizations.of(context)!.taskName,
                defController: taskCont),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                defText: AppLocalizations.of(context)!.addDescription,
                defController: descriptionCont),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              defText: AppLocalizations.of(context)!.date,
              defWidth: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                  ? 0.4 * screenWidth
                  : 0.7 * screenWidth,
              defIconPref: const Icon(Icons.date_range),
              defController: dateCont,
              defOnTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 356)))
                    .then((value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    dateCont.text = DateFormat('yyyy-MM-dd').format(value);
                  });
                });
              },
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              defText: AppLocalizations.of(context)!.time,
              defWidth: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                  ? 0.4 * screenWidth
                  : 0.7 * screenWidth,
              defIconPref: const Icon(Icons.access_time),
              defController: timeCont,
              defOnTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    timeCont.text = value.format(context).toString();
                  });
                });
              },
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child:  Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child:  Text(AppLocalizations.of(context)!.edit),
            onPressed: () {
              TaskEntity taskEntity = TaskEntity(
                isDone: widget.task.isDone,
                categoryId: widget.task.categoryId,
                  userId: widget.task.taskId,
                  taskName: taskCont.text,
                  description: descriptionCont.text,
                  taskDate: dateCont.text,
                  taskTime: timeCont.text,
                  taskId: widget.task.taskId);
              BlocProvider.of<TaskOperationsBloc>(context)
                  .add(UpdateTaskEvent(taskEntity: taskEntity));
            },
          ),
        ]);
  }
}
