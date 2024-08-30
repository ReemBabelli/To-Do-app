import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';

class ShowProductivityUseCase{
  final TaskRepository repository;

  ShowProductivityUseCase({required this.repository});

  Future<Either<String , Map<String,double>>> call() async{
    return await repository.showProductivity();
  }
}