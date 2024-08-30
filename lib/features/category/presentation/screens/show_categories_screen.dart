import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoriesBloc/categories_blocs.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import '../../../../core/strings/route_names.dart';
import '../../../../core/widgets/error_message_widget.dart';
import '../widgets/show_categories_widgets/category_list_widget.dart';
import 'package:to_do_app/core/utilities/injection_container.dart' as di;

class ShowCategoriesScreen extends StatefulWidget {

  const ShowCategoriesScreen({super.key});

  @override
  State<ShowCategoriesScreen> createState() => _ShowCategoriesScreenState();
}

class _ShowCategoriesScreenState extends State<ShowCategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesBloc>().add(GetAllCategoriesEvent());
    return SafeArea(
        child: Scaffold(
          body: _buildBody(),
          floatingActionButton:buildFloatingButton(context),
        ));
  }

  _buildBody() {
    return BlocBuilder<CategoriesBloc, CategoriesStates>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const LoadingWidget();
        } else if (state is LoadedCategoriesState) {
          return CategoryListWidget(
            categories: state.categories,
          );
        } else if (state is CategoriesErrorMessageState) {
          return ErrorMessageWidget(message: state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {
        GoRouter.of(context).goNamed(RouteNames.addCategory);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
