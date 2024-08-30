import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';
import 'package:to_do_app/features/category/domain/use_cases/add_category_use_case.dart';
import 'package:to_do_app/features/category/domain/use_cases/delete_category_use_case.dart';
import 'package:to_do_app/features/category/domain/use_cases/update_category_use_case.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../../../core/strings/success_messages.dart';

part 'category_operations_events.dart';
part 'category_operations_states.dart';

class CategoryOperationsBloc extends Bloc<CategoryOperationsEvent , CategoryOperationsStates>{
  final AddCategoryUseCase addCategory;
  final DeleteCategoryUseCase deleteCategory;
  final UpdateCategoryUseCase updateCategory;

  CategoryOperationsBloc({required this.addCategory, required this.deleteCategory, required this.updateCategory})
  :super(CategoryInitialState()){
    on<CategoryOperationsEvent>(
        (event , emit) async {
          if( event is AddCategoryEvent){
            emit(CategoryLoadingState());
            final failureOrMessage = await addCategory(event.categoryEntity);
            emit(_foldMessage(failureOrMessage , addCatSuccessMsg));
          } else if(event is DeleteCategoryEvent){
            emit(CategoryLoadingState());
            final failureOrMessage = await deleteCategory(event.categoryId);
            emit(_foldMessage(failureOrMessage , deleteCatSuccessMsg));
          } else if( event is UpdateCategoryEvent){
            emit(CategoryLoadingState());
            final failureOrMessage = await updateCategory(event.categoryEntity);
            emit(_foldMessage(failureOrMessage , updateCatSuccessMsg));
          }
        }
    );
  }

}

CategoryOperationsStates _foldMessage(Either<Failure, Unit> failureOrMessage , String message){
  return failureOrMessage.fold(
          (failure) => CategoryErrorMessageState(message: _mapToString(failure)),
          (_) => CategorySuccessMessageState(message: message)
  );
}

String _mapToString(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMsg;
    case OffLineFailure:
      return offlineMsg;
    default:
      return "Unexpected error , please try again later.";
  }
}
