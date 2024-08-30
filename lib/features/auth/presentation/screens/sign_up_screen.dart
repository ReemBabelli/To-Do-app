import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/utilities/snack_bar_message.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import 'package:to_do_app/core/strings/route_names.dart';

import '../widgets/sign_up_widgets/form_sign_up_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _buildBody()
        )
    );
  }

  _buildBody() {
    return BlocConsumer<AuthBloc,AuthState>(
        builder: (context , state){
          if(state is AuthLoadingState){
            return const LoadingWidget();
          } else {
            return const FormSignUpWidget();
          }
        },
        listener: (context , state){
          if(state is AuthDataState){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            GoRouter.of(context).goNamed(RouteNames.userFile);
          } else if(state is AuthErrorState){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
        }
    );
  }
}
