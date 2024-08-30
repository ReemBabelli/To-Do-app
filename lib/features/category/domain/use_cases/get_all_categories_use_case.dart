import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/category/domain/repositories/category_repository.dart';

import '../entities/category_entity.dart';

class GetAllCategoriesUseCase{
  final CategoryRepository repository;

  GetAllCategoriesUseCase({required this.repository});

  Future<Either<Failure , List<CategoryEntity>>> call() async{
    return await repository.getAllCategories();
  }
}