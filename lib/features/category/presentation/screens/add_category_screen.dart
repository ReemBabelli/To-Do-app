import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/utilities/snack_bar_message.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:to_do_app/core/strings/route_names.dart';

import '../widgets/add_category_widgets/form_category_widget.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _buildBody(),
        ));
  }

  _buildBody() {
    return BlocConsumer<CategoryOperationsBloc , CategoryOperationsStates>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const LoadingWidget();
          } else {
            return const FormCategoryWidget();
          }
        },
        listener: (context, state) {
          if (state is CategorySuccessMessageState) {
            SnackBarMessage().showSuccessSnackBar(
                message:state.message, context: context);
            GoRouter.of(context).goNamed(RouteNames.showCategories);
          } else if(state is CategoryErrorMessageState){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
        }
    );
  }

}
