import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoriesBloc/categories_blocs.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import '../../../../core/strings/route_names.dart';
import '../../../../core/widgets/error_message_widget.dart';
import '../../../../core/utilities/styles.dart';
import '../widgets/show_categories_widgets/category_list_widget.dart';
import 'package:to_do_app/core/utilities/injection_container.dart' as di;

class Show1CategoriesScreen extends StatefulWidget {
  const Show1CategoriesScreen({super.key});

  @override
  State<Show1CategoriesScreen> createState() => _Show1CategoriesScreenState();
}

class _Show1CategoriesScreenState extends State<Show1CategoriesScreen> {

  @override
  Widget initState() {
    return BlocProvider(
        create: (_) => di.sl<CategoriesBloc>()..add(GetAllCategoriesEvent()),
        child: SafeArea(
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: _buildBody(),
            )));
  }

  @override
  Widget build(BuildContext context) {
      return SizedBox();
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(AppLocalizations.of(context)!.myCategories,
          style: getWhiteTitle(context)),
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).goNamed(RouteNames.addCategory);
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
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
}


