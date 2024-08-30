import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/is_logged_in_use_case.dart';

part 'is_logged_in_events.dart';

part 'is_logged_in_states.dart';

class IsLoggedInBloc extends Bloc<IsLoggedInBlocEvent, IsLoggedInState> {
  final IsLoggedInUseCase isLoggedIn;

  IsLoggedInBloc({ required this.isLoggedIn})
      :super(IsLoggedInInitialState()) {
    on<IsLoggedInBlocEvent>((event, emit) async {
       if(event is IsLoggedInEvent){
      final data = await isLoggedIn();
      emit(fold(data));
      }

    });
  }
}

IsLoggedInState fold(Either<String, bool> failureOrData) {
  return failureOrData.fold(
          (failure) => IsLoggedInErrorState(message: failure),
          (isLoggedIn) => IsLoggedInDataState(isLoggedIn: isLoggedIn)
  );
}

