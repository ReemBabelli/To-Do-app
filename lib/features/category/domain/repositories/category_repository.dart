import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';

abstract class CategoryRepository{
  Future<Either<Failure , Unit>> addCategory(CategoryEntity category);
  Future<Either<Failure , Unit>> updateCategory(CategoryEntity category);
  Future<Either<Failure , Unit>> deleteCategory(String categoryId);
  Future<Either<Failure , List<CategoryEntity>>> getAllCategories();
}