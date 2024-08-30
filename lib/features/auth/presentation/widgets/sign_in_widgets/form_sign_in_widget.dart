import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:to_do_app/features/auth/domain/entities/user_entity.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import '../../../../../core/strings/route_names.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/password_textField_widget.dart';
import '../../../../../core/widgets/textField_widget.dart';
import '../../../../../resources/resources.dart';
import '../../../../../core/widgets/button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSignInWidget extends StatefulWidget {
  const FormSignInWidget({super.key});

  @override
  State<FormSignInWidget> createState() => _FormSignInWidgetState();
}

class _FormSignInWidgetState extends State<FormSignInWidget> {
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: ResponsiveRowColumn(
            layout: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            rowPadding: const EdgeInsets.all(10),
            columnPadding: const EdgeInsets.all(10),
            children: [
              ResponsiveRowColumnItem(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Image.asset(Images.m7,
                      width: constraints.maxWidth > 800.0
                          ? screenWidth / 2
                          : screenWidth,
                      height: constraints.maxWidth > 800.0
                          ? screenWidth / 2
                          : screenWidth,
                      fit: BoxFit.cover);
                }),
              ),
              ResponsiveRowColumnItem(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constrains) {
                  return Column(
                    children: [
                      Center(
                        child: TextFieldWidget(
                          defText: AppLocalizations.of(context)!.email,
                          defController: emailCont,
                          defIconPref: const Icon(Icons.email_outlined),
                          defWidth: constrains.maxWidth > 800.0
                              ? 0.4 * screenWidth
                              : 0.7 * screenWidth,
                          defKey: TextInputType.emailAddress,
                          defValidator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .emailValidation;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      PasswordTextFieldWidget(
                        defController: passwordCont,
                        defWidth: constrains.maxWidth > 800.0
                            ? 0.4 * screenWidth
                            : 0.7 * screenWidth,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ButtonWidget(
                          defWid: constrains.maxWidth > 800.0
                              ? 0.1 * screenWidth
                              : 0.3 * screenWidth,
                          defText: AppLocalizations.of(context)!.signIn,
                          defOnTap: () async {
                            if (formKey.currentState!.validate()) {
                              final user = UserEntity(
                                userName: 'reem',
                                  email: emailCont.text,
                                  password: passwordCont.text);
                              BlocProvider.of<AuthBloc>(context).add(
                                  SignInEvent(user: user));
                            }
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.haveAcc,
                        style: getBlackText(context),
                      ),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).goNamed(RouteNames.signUp);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.createAcc,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  );
                }),
              )
            ],
          ),
        ));
  }
}
