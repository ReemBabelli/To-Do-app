import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/domain/use_cases/add_task_use_case.dart';
import 'package:to_do_app/features/task/domain/use_cases/delete_task_use_case.dart';
import 'package:to_do_app/features/task/domain/use_cases/update_task._use_case.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_events.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_states.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../../../core/strings/success_messages.dart';
import '../../../domain/use_cases/do_task_use_case.dart';

class TaskOperationsBloc
    extends Bloc<TaskOperationsEvent, TaskOperationsStates> {
  final AddTaskUseCase addTask;
  final DeleteTaskUseCase deleteTask;
  final UpdateTaskUseCase updateTask;
  final DoTaskUseCase doTask;

  TaskOperationsBloc(
      {required this.addTask,
      required this.deleteTask,
      required this.updateTask,
      required this.doTask})
      : super(TaskInitialState()) {
    on<TaskOperationsEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(TaskLoadingState());
        final failureOrMessage = await addTask(event.taskEntity);
        emit(_fold(failureOrMessage, addTaskSuccessMsg));
      } else if(event is DeleteTaskEvent){
        emit(TaskLoadingState());
        final failureOrMessage = await deleteTask(event.taskId);
        emit(_fold(failureOrMessage, deleteTaskSuccessMsg));
      }else if(event is UpdateTaskEvent){
        emit(TaskLoadingState());
        final failureOrMessage = await updateTask(event.taskEntity);
        emit(_fold(failureOrMessage, updateTaskSuccessMsg));
      }else if (event is DoTaskEvent){
        emit(TaskLoadingState());
        final failureOrMessage = await doTask(event.taskId , event.isDone);
        String message;
        if(event.isDone == true){
           message = doTaskSuccessMsg;
        }else{
           message =noTaskSuccessMsg;
        }
        emit(_fold(failureOrMessage, message));
      }
    });
  }

  TaskOperationsStates _fold(
      Either<Failure, Unit> failureOrMessage, String message) {
    return failureOrMessage.fold(
        (failure) => TaskErrorMessageState(message: _mapToString(failure)),
        (_) => TaskSuccessMessageState(message: message));
  }

  _mapToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMsg;
      case OffLineFailure:
        return offlineMsg;
      default:
        return "Unexpected error , please try again later.";
    }
  }
}
