import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';
import '../../../../../core/widgets/textField_widget.dart';
import '../../blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateDialogWidget extends StatefulWidget {
  final CategoryEntity category;

  const UpdateDialogWidget({super.key, required this.category});

  @override
  State<UpdateDialogWidget> createState() => _UpdateDialogWidgetState();
}

class _UpdateDialogWidgetState extends State<UpdateDialogWidget> {
  TextEditingController updateCont = TextEditingController();

  @override
  void initState() {
    updateCont.text = widget.category.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title:  Text(AppLocalizations.of(context)!.renameCategory),
        content: TextFieldWidget(
            defText: widget.category.categoryName, defController: updateCont),
        actions: <Widget>[
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child:  Text(AppLocalizations.of(context)!.rename),
            onPressed: () {
              CategoryEntity categoryEntity =
                  CategoryEntity(categoryName: updateCont.text , categoryId: widget.category.categoryId);
              BlocProvider.of<CategoryOperationsBloc>(context)
                  .add(UpdateCategoryEvent(categoryEntity: categoryEntity));
            },
          ),
        ]);
  }
}
