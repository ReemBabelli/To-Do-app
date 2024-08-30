import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/task/domain/use_cases/show_productivity_use_case.dart';

part 'productivity_events.dart';

part 'productivity_states.dart';

class ProductivityBloc extends Bloc<ProductivityEvents, ProductivityStates> {
  final ShowProductivityUseCase showProductivity;

  ProductivityBloc(
      {required this.showProductivity})
      : super(ProductivityInitialState()) {
    on<ProductivityEvents>((event, emit) async {
      if (event is ShowProductivityEvent) {
        emit(ProductivityLoadingState());
        final productivity = await showProductivity();
        emit(_fold(productivity));
      }
    });
  }

  ProductivityStates _fold(Either<String, Map<String, double>> productivity) {
    return productivity.fold(
        (failure) => ProductivityErrorState(message: failure),
        (productivity) => ProductivityDataState(productivity: productivity));
  }
}
