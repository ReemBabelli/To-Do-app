import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/core/widgets/textField_widget.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController defController;
  final double? defWidth;
  final bool? defEnabled;

  const PasswordTextFieldWidget(
      {super.key,
      required this.defController,
      this.defWidth = double.infinity,
      this.defEnabled});

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      defText: AppLocalizations.of(context)!.password,
      defWidth: widget.defWidth,
      defController: widget.defController,
      defIconPref: const Icon(Icons.lock),
      defIconSuf: IconButton(
          icon: Icon(state ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState((){
              state = !state;
            });
          }),
      defObs: !state,
      defValidator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.passwordValidation;
        }
        return null;
      },
      defKey: TextInputType.visiblePassword,

    );
  }
}
