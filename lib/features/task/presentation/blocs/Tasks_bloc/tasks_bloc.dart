import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/task/domain/entities/task_entity.dart';
import 'package:to_do_app/features/task/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_events.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_states.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../domain/use_cases/get_today_tasks_use_case.dart';

class TasksBloc extends Bloc<TasksEvent, TasksStates> {
  final GetAllTasksUseCase getAllTasks;
  final GetTodayTasksUseCase getTodayTasks;

  TasksBloc({required this.getAllTasks , required this.getTodayTasks}) : super(TasksInitialState()) {
    on<TasksEvent>((event, emit) async {
      if (event is GetAllTasksEvent) {
        emit(TasksLoadingState());
        final failureOrTasks = await getAllTasks(event.categoryId);
        emit(_fold(failureOrTasks));
      } else if (event is GetTodayTasksEvent) {
        emit(TasksLoadingState());
        final failureOrTasks = await getTodayTasks();
        emit(_fold(failureOrTasks));
      }
    });
  }

  TasksStates _fold(Either<Failure, List<TaskEntity>> failureOrTasks) {
    return failureOrTasks.fold((failure) =>
        TasksErrorMessageState(message: _mapToString(failure)),
            (tasks) => LoadedTasksState(tasks: tasks));
  }

 String _mapToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMsg;
      case EmptyCacheFailure:
        return emptyCacheMsg;
      default:
        return "Unexpected error , please try again later.";
    }
  }
}