part of 'category_operations_blocs.dart';

abstract class CategoryOperationsEvent {
  CategoryOperationsEvent();
}

class AddCategoryEvent extends CategoryOperationsEvent {
  final CategoryEntity categoryEntity;

  AddCategoryEvent({required this.categoryEntity});
}

class DeleteCategoryEvent extends CategoryOperationsEvent{
  final String categoryId;

  DeleteCategoryEvent({required this.categoryId});
}

class UpdateCategoryEvent extends CategoryOperationsEvent {
  final CategoryEntity categoryEntity;

  UpdateCategoryEvent({required this.categoryEntity});
}



