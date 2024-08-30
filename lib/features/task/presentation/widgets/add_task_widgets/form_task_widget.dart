import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_bloc.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_events.dart';
import '../../../../../core/widgets/label_widget.dart';
import '../../../../../core/widgets/textField_widget.dart';
import '../../../../../resources/resources.dart';
import '../../../../../core/widgets/button_widget.dart';

class FormTaskWidget extends StatefulWidget {
  final String categoryId;

  const FormTaskWidget({super.key, required this.categoryId});

  @override
  State<FormTaskWidget> createState() => _FormTaskWidgetState();
}

class _FormTaskWidgetState extends State<FormTaskWidget> {
  var taskCont = TextEditingController();
  var descriptionCont = TextEditingController();
  var dateCont = TextEditingController();
  var timeCont = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                    defWidth: 0.6 * screenWidth,
                    defText: AppLocalizations.of(context)!.createTask),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Image.asset(Images.m8,
                      width: 100.0, height: 150.0, fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: TextFieldWidget(
                    defText: AppLocalizations.of(context)!.taskName,
                    defWidth:
                        ResponsiveBreakpoints.of(context).largerThan(TABLET)
                            ? 0.4 * screenWidth
                            : 0.7 * screenWidth,
                    defIconPref: const Icon(Icons.task),
                    defController: taskCont,
                    defKey: TextInputType.text,
                    defMaxLines: 1,
                    defValidator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.taskValidation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: TextFieldWidget(
                    defText: AppLocalizations.of(context)!.addDescription,
                    defWidth:
                        ResponsiveBreakpoints.of(context).largerThan(TABLET)
                            ? 0.4 * screenWidth
                            : 0.7 * screenWidth,
                    defHeight: 100,
                    defController: descriptionCont,
                    defKey: TextInputType.text,
                    defMinLines: 1,
                    defMaxLines: 5,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: TextFieldWidget(
                    defText: AppLocalizations.of(context)!.date,
                    defWidth:
                        ResponsiveBreakpoints.of(context).largerThan(TABLET)
                            ? 0.4 * screenWidth
                            : 0.7 * screenWidth,
                    defIconPref: const Icon(Icons.date_range),
                    defController: dateCont,
                    defOnTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 356)))
                          .then((value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          dateCont.text =
                              DateFormat('yyyy-MM-dd').format(value);
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: TextFieldWidget(
                    defText: AppLocalizations.of(context)!.time,
                    defWidth:
                        ResponsiveBreakpoints.of(context).largerThan(TABLET)
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
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: ButtonWidget(
                      defWid:
                          ResponsiveBreakpoints.of(context).largerThan(TABLET)
                              ? 0.1 * screenWidth
                              : 0.3 * screenWidth,
                      defText: AppLocalizations.of(context)!.create,
                      defOnTap: () {
                        if (formKey.currentState!.validate()) {
                          TaskEntity taskEntity = TaskEntity(
                              categoryId: widget.categoryId,
                              description: descriptionCont.text,
                              taskTime: timeCont.text,
                              taskName: taskCont.text,
                              taskDate: dateCont.text,
                              isDone: false);
                          BlocProvider.of<TaskOperationsBloc>(context)
                              .add(AddTaskEvent(taskEntity: taskEntity));
                          //BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent(categoryId: widget.categoryId));
                        }
                      }),
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
