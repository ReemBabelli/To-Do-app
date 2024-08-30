import 'package:dartz/dartz.dart';
import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:to_do_app/features/auth/domain/use_cases/Sign_in_use_case.dart';
import 'package:to_do_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:to_do_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:bloc/bloc.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../../../core/strings/success_messages.dart';


part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent , AuthState>{
  final SignInUseCase signIn;
  final SignUpUseCase signUp;
  final LogoutUseCase logout;

  AuthBloc( {required this.signIn, required this.signUp,required this.logout})
  :super(AuthInitialState()){
    on<AuthEvent>((event , emit)async{

      if(event is SignInEvent){
        emit(AuthLoadingState());
        final failureOrData = await signIn(event.user);
        emit(fold(failureOrData , loggedInMsg));
      }

      else if(event is SignUpEvent){
        emit(AuthLoadingState());
        final failureOrData = await signUp(event.user);
        emit(fold(failureOrData , loggedInMsg));
      }

      else if(event is LogoutEvent){
        emit(AuthLoadingState());
        final failureOrData = await logout();
        emit(fold(failureOrData , loggedOutMsg));
      }

    });
  }
}

AuthState fold(Either<Failure,Unit> failureOrData , String successMessage){
  return failureOrData.fold(
          (failure) => AuthErrorState(message: _mapToString(failure)),
          (_) => AuthDataState(message: successMessage)
  );
}

String _mapToString(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMsg;
    case OffLineFailure:
      return offlineMsg;
    case UserNotFoundFailure:
      return wrongUserMsg;
    default:
      return "Unexpected error , please try again later.";
  }
}

