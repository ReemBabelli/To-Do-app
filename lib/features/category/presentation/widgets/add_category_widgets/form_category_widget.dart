import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/label_widget.dart';
import '../../../../../core/widgets/textField_widget.dart';
import '../../../../../resources/resources.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../domain/entities/category_entity.dart';
import '../../blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class FormCategoryWidget extends StatefulWidget {
  const FormCategoryWidget({super.key});

  @override
  State<FormCategoryWidget> createState() => _FormCategoryWidgetState();
}

class _FormCategoryWidgetState extends State<FormCategoryWidget> {
  var categoryCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWidget(
              defWidth: 0.6 * screenWidth,
              defText: AppLocalizations.of(context)!.createCategory),
          const SizedBox(
            height: 30.0,
          ),
          LayoutBuilder(builder: (context, constrains) {
            return Column(
              children: [
                Center(
                  child: Image.asset(Images.m8,
                      width: 100.0, height: 150.0, fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Form(
                    key: formKey,
                    child: TextFieldWidget(
                      defWidth: constrains.maxWidth > 800.0
                          ? 0.4 * screenWidth
                          : 0.7 * screenWidth,
                      defController: categoryCont,
                      defText: AppLocalizations.of(context)!.categoryName,
                      defKey: TextInputType.text,
                      defValidator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .categoryValidation;
                        }
                        return null;
                      },
                      defIconPref: const Icon(Icons.grid_on_rounded),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: ButtonWidget(
                      defWid: constrains.maxWidth > 800.0
                          ? 0.1 * screenWidth
                          : 0.3 * screenWidth,
                      defText: AppLocalizations.of(context)!.create,
                      defOnTap: () {
                        if (formKey.currentState!.validate()) {
                          CategoryEntity category = CategoryEntity(
                              categoryName: categoryCont.text );
                          BlocProvider.of<CategoryOperationsBloc>(context).add(
                              AddCategoryEvent(categoryEntity: category));
                        }
                      }),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
