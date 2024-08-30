import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String? categoryId;

  const DeleteDialogWidget({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.areYouSure),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.no)),
        TextButton(
            onPressed: () {
              BlocProvider.of<CategoryOperationsBloc>(context)
                  .add(DeleteCategoryEvent(categoryId: categoryId!));
            },
            child: Text(AppLocalizations.of(context)!.yes)),
      ],
    );
  }
}
