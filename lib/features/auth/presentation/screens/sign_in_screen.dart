import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/utilities/snack_bar_message.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/strings/route_names.dart';
import '../widgets/sign_in_widgets/form_sign_in_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBody(),
    ));
  }

  _buildBody() {
    return BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthLoadingState) {
        return const LoadingWidget();
      } else {
        return const FormSignInWidget();
      }
    }, listener: (context, state) {
      if (state is AuthDataState) {
        SnackBarMessage()
            .showSuccessSnackBar(message: state.message, context: context);
        GoRouter.of(context).goNamed(RouteNames.showCategories);
      } else if (state is AuthErrorState) {
        SnackBarMessage()
            .showErrorSnackBar(message: state.message, context: context);
      }
    });
  }
}
