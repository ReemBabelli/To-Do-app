import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/core/language/cubits/locale_cubit.dart';

class RadioButtonWidget extends StatefulWidget {

  const RadioButtonWidget({
    super.key,

  });


  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit , LocaleStates>(
      builder: (context , state) {
        if (state is ChangeLocaleState){
          int? radioValue = state.locale ==  AppLocalizations.supportedLocales[0] ? 0 : 1;
          return Column(
            children: [
              Row(children: [
                const SizedBox(width: 7,),
                Text(AppLocalizations.of(context)!.language)
              ]),
              Row(
                children: [
                  const SizedBox(width: 12),
                  Radio<int>(
                    activeColor: Colors.blueGrey,
                    value: 1,
                    groupValue: radioValue,
                    onChanged: (value) {
                      setState(() {
                        radioValue = value;
                        context.read<LocaleCubit>().changeLanguage('en');
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  Text(AppLocalizations.of(context)!.english)
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 12),
                  Radio<int>(
                    activeColor: Colors.blueGrey,
                    value: 0,
                    groupValue: radioValue,
                    onChanged: (value) {
                      setState(() {
                        radioValue = value;
                        context.read<LocaleCubit>().changeLanguage('ar');
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  Text(AppLocalizations.of(context)!.arabic)
                ],
              )
            ],
          );
        }
        else{
          return const SizedBox();
        }

      }
    );
  }


}
