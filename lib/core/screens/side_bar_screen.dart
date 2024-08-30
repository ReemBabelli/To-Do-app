import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/core/widgets/radioButton_widget.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import '../../resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../strings/route_names.dart';
import '../utilities/snack_bar_message.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({
    super.key,
  });

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  @override
  Widget build(BuildContext context) {
    //Object? radioValue;
    double screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return UserAccountsDrawerHeader(
              accountName: const Text(' '),
              accountEmail: const Text(''),
              currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                child: Image.asset(Images.m15,
                    width: constraints.maxWidth > 800.0
                        ? screenWidth / 3
                        : screenWidth / 4,
                    height: constraints.maxWidth > 800.0
                        ? screenWidth / 3
                        : screenWidth / 4,
                    fit: BoxFit.cover),
              )),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.m21), fit: BoxFit.cover)),
            );
          }),
          const RadioButtonWidget(),
          const SizedBox(height: 20,),
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const LoadingWidget();
              } else {
                return InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                  child: Row(
                      children: [
                        const SizedBox(width: 7,),
                        const Icon(Icons.logout),
                        Text(AppLocalizations.of(context)!.logout)
                      ]),
                );
              }
            },
            listener: (context, state) {
              if (state is AuthDataState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pop();
                //GoRouter.of(context).goNamed(RouteNames.signIn);
              } else if (state is AuthErrorState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
              }
            },
          )
        ],
      ),
    );
  }
}
