import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:to_do_app/features/task/presentation/widgets/productivity_widgets/percent_indicator_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductivityListWidget extends StatelessWidget {
  final double productivityToday;
  final double productivityThisMonth;

  const ProductivityListWidget(
      {super.key,
      required this.productivityToday,
      required this.productivityThisMonth});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBody(context),
    ));
  }

  _buildBody(BuildContext context) {
    return Center(
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).largerThan(TABLET)
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        rowMainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ResponsiveRowColumnItem(child: SizedBox(height: 20)),
          ResponsiveRowColumnItem(
            child: PercentIndicatorWidget(
              productivity: productivityToday,
              footer: AppLocalizations.of(context)!.productivityForToday,
              radius: 110,
            ),
          ),
          const ResponsiveRowColumnItem(child: SizedBox(height: 20)),
          ResponsiveRowColumnItem(
            child: PercentIndicatorWidget(
                productivity: productivityThisMonth,
                footer: AppLocalizations.of(context)!.productivityOfThisMonth,
                radius: 90),
          ),
          const ResponsiveRowColumnItem(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
