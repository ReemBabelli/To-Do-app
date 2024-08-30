import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/category/data/models/category_model.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_sources/category_local_data_source.dart';
import '../data_sources/category_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class CategoryRepositoryImp implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImp({required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addCategory(CategoryEntity category) async {
    String? userId = await localDataSource.getUserId() ?? '';
    CategoryModel categoryModel =
    CategoryModel(categoryName: category.categoryName, userId: userId);
    return await _getMessage(() => remoteDataSource.addCategory(categoryModel));
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String categoryId) async {
    return await _getMessage(() => remoteDataSource.deleteCategory(categoryId));
  }

  @override
  Future<Either<Failure, Unit>> updateCategory(CategoryEntity category) async {
    CategoryModel categoryModel = CategoryModel(
        categoryName: category.categoryName,
        userId: category.userId,
        categoryId: category.categoryId);
    return await _getMessage(() => remoteDataSource.updateCategory(
    categoryModel
    )
    );

  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    String? userId = await localDataSource.getUserId() ?? "";
    if (await networkInfo.isConnected) {
      try {
        List<CategoryModel> response =
        await remoteDataSource.getAllCategories(userId);
        localDataSource.cacheCategories(response, userId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    } else {
      try {
        List<CategoryModel> categories =
        await localDataSource.getCachedCategories(userId);
        return Right(categories);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
