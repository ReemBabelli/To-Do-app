import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widgets/error_message_widget.dart';
import 'package:to_do_app/core/widgets/loading_widget.dart';
import 'package:to_do_app/features/task/presentation/blocs/productivity_bloc/productivity_bloc.dart';
import 'package:to_do_app/features/task/presentation/widgets/productivity_widgets/productivity_list_widget.dart';
import '../widgets/productivity_widgets/percent_indicator_widget.dart';
import '../../../../core/utilities/injection_container.dart' as di;

class ProductivityScreen extends StatelessWidget {
  const ProductivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProductivityBloc>()..add(ShowProductivityEvent()),
      child: SafeArea(
          child: Scaffold(
        body: _buildBody(),
      )),
    );
  }

  _buildBody() {
    return BlocBuilder<ProductivityBloc, ProductivityStates>(
      builder: (context, state) {
        if (state is ProductivityLoadingState) {
          return const LoadingWidget();
        } else if (state is ProductivityErrorState) {
          return ErrorMessageWidget(message: state.message);
        } else if (state is ProductivityDataState) {
          return ProductivityListWidget(
            productivityToday: state.productivity['productivityToday']!,
            productivityThisMonth: state.productivity['productivityThisMonth']!,
          );
        }
        return const SizedBox();
      },
    );
  }
}
