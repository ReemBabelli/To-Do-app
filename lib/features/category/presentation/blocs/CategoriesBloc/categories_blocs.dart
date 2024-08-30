import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/category/domain/use_cases/get_all_categories_use_case.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

part 'categories_events.dart';

part 'categories_states.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesStates> {
  final GetAllCategoriesUseCase getAllCategories;

  CategoriesBloc({required this.getAllCategories})
      : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is GetAllCategoriesEvent) {
        emit(CategoriesLoadingState());
        final failureOrCategories = await getAllCategories();
        emit(_fold(failureOrCategories));
      }
    });
  }
}

CategoriesStates _fold(
    Either<Failure, List<CategoryEntity>> failureOrCategories) {
  return failureOrCategories.fold(
      (failure) => CategoriesErrorMessageState(message: _mapToString(failure)),
      (categories) => LoadedCategoriesState(categories: categories));
}

String _mapToString(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMsg;
    case EmptyCacheFailure:
      return emptyCacheMsg;
    default:
      return "Unexpected error , please try again later.";
  }
}
