import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:to_do_app/features/category/presentation/widgets/show_categories_widgets/category_widget.dart';
import '../../../domain/entities/category_entity.dart';

class CategoryListWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoryListWidget({super.key , required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveBreakpoints.of(context).largerThan(TABLET)?4:3,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) =>
          CategoryWidget(category: categories[index],
          ),

    );
  }
}
