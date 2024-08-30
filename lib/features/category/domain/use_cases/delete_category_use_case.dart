import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/category/domain/repositories/category_repository.dart';

import '../../../../core/errors/failures.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String categoryId) async {
    return await repository.deleteCategory(categoryId);
  }
}
