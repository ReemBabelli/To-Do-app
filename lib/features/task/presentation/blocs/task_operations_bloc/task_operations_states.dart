abstract class TaskOperationsStates {

  TaskOperationsStates();
}

class TaskInitialState extends TaskOperationsStates{}

class TaskLoadingState extends TaskOperationsStates{}

class TaskSuccessMessageState extends TaskOperationsStates{
  final String message;

  TaskSuccessMessageState({required this.message});
}

class TaskErrorMessageState extends TaskOperationsStates{
  final String message;

  TaskErrorMessageState({required this.message});
}