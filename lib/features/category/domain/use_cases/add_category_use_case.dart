import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';
import 'package:to_do_app/features/category/domain/repositories/category_repository.dart';

import '../../../../core/errors/failures.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(CategoryEntity category) async {
    return await repository.addCategory(category);
  }
}
