import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/category/data/models/category_model.dart';
import 'package:to_do_app/main.dart';

abstract class CategoryRemoteDataSource {
  Future<Unit> addCategory(CategoryModel categoryModel);

  Future<Unit> deleteCategory(String categoryId);

  Future<Unit> updateCategory(CategoryModel categoryModel);

  Future<List<CategoryModel>> getAllCategories(String? userId);
}

class CategoryRemoteDataSourceImp implements CategoryRemoteDataSource {
  final databases = Databases(client);

  @override
  Future<Unit> addCategory(CategoryModel categoryModel) async {
    try {
      await databases.createDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6542753978ca3cb97917',
          documentId: ID.unique(),
          data: categoryModel.toJson());
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteCategory(String categoryId) async {
    try {
      await databases.deleteDocument(
        databaseId: '6526bcf9dc82afeb08da',
        collectionId: '6542753978ca3cb97917',
        documentId: categoryId,
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> updateCategory(CategoryModel categoryModel) async {
    try {
      await databases.updateDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6542753978ca3cb97917',
          documentId: categoryModel.categoryId!,
          data: {
            'categoryName': categoryModel.categoryName,
          });
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories(String? userId) async {
    try {
      DocumentList response = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6542753978ca3cb97917',
          queries: [Query.equal('userId', userId)]);
      List<CategoryModel> catModel = response.documents
          .map<CategoryModel>(
              (doc) => CategoryModel.fromJson(doc.data, doc.$id))
          .toList();
      if(catModel !=null)
      {
        return catModel;
      }else{
        throw EmptyCacheException();
      }
    } catch(e){
      throw ServerException();
    }
  }
}
