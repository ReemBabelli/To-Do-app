import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(CategoryEntity category) async {
    return await repository.updateCategory(category);
  }
}