import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/utilities/snack_bar_message.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/category/domain/entities/category_entity.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoriesBloc/categories_blocs.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:to_do_app/features/category/presentation/widgets/show_categories_widgets/delete_dialog_widget.dart';
import 'package:to_do_app/features/category/presentation/widgets/show_categories_widgets/update_dialog_widget.dart';
import '../../../../../core/strings/route_names.dart';
import '../../../../../core/utilities/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryEntity category;

  const CategoryWidget(
      {super.key, required this.category});

  @override
  Widget build(BuildContext context) {
     List<String> list = <String>[AppLocalizations.of(context)!.rename, AppLocalizations.of(context)!.delete];
    return InkWell(
      child: Card(
        color: Colors.white,
        child: Stack(children: [
          Center(
              child: Text(
            category.categoryName,
            style: getBlueGreyTitle(context),
          )),
          Positioned(
              bottom: 0,
              left: 3,
              child: DropdownButton<String>(
                icon: const Icon(Icons.more_horiz),
                style: const TextStyle(color: Colors.blueGrey),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  if (value == list[1]) {
                    _deleteDialog(context);
                  } else {
                    _updateDialog(context);
                  }
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        ]),
      ),
      onTap: (){
        GoRouter.of(context).goNamed(RouteNames.showTasks , pathParameters: {'categoryID':category.categoryId!});
      },
    );
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<CategoryOperationsBloc, CategoryOperationsStates>(
              builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(categoryId: category.categoryId);
          }, listener: (context, state) {
            if (state is CategorySuccessMessageState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              BlocProvider.of<CategoriesBloc>(context)
                  .add(GetAllCategoriesEvent());
              Navigator.of(context).pop();
            } else if (state is CategoryErrorMessageState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          });
        });
  }

  void _updateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<CategoryOperationsBloc, CategoryOperationsStates>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const AlertDialog(title: LoadingWidget());
                }
                return UpdateDialogWidget(category: category);
              }, listener: (context, state) {
            if (state is CategorySuccessMessageState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              BlocProvider.of<CategoriesBloc>(context)
                  .add(GetAllCategoriesEvent());
              Navigator.of(context).pop();
            } else if (state is CategoryErrorMessageState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          });
        });
  }
}
