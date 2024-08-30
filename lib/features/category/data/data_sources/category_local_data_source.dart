import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/errors/exceptions.dart';

import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<String?> getUserId();

  Future<Unit> cacheCategories(List<CategoryModel> categoryModels , String userId);

  Future<List<CategoryModel>> getCachedCategories(String userId);
}

class CategoryLocalDataSourceImp implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString('userId');
  }

  @override
  Future<Unit> cacheCategories(List<CategoryModel> categoryModels , String userId) {
    List categoryToJson = categoryModels
        .map<Map<String, dynamic>>((categoryModel) => categoryModel.toJson())
        .toList();
    sharedPreferences.setString('categories$userId', jsonEncode(categoryToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CategoryModel>> getCachedCategories(String userId) {
    final categoriesJson = sharedPreferences.getString('categories$userId');
    if (categoriesJson != null) {
      List categoriesFromJson = jsonDecode(categoriesJson);
      List<CategoryModel> categoryModels = categoriesFromJson
          .map<CategoryModel>(
              (jsonCategory) => CategoryModel.fromJson(jsonCategory , '6550978e869786d11458'))
          .toList();
      return Future.value(categoryModels);
    }else{
      throw EmptyCacheException();
    }

  }
}
