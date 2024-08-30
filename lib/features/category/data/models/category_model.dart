import 'package:to_do_app/features/category/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {

  CategoryModel({
    required String categoryName,
     String ? categoryId,
    String ? userId,
  }) : super(categoryName: categoryName, categoryId: categoryId , userId: userId);

  factory CategoryModel.fromJson(Map<String, dynamic> json, String? id) {
    return CategoryModel(
        categoryName: json['categoryName'],
        userId: json['userId'],
        categoryId: id);
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'userId': userId,
    };
  }
}
