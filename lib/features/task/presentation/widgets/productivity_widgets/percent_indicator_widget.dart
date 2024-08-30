import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_app/core/utilities/styles.dart';

class PercentIndicatorWidget extends StatelessWidget {
  final double productivity;
  final String footer;
  final double radius;

  const PercentIndicatorWidget(
      {super.key,
      required this.productivity,
      required this.footer,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 13.0,
      animation: true,
      percent: productivity / 100,
      center: Text(
        '${productivity.toString()}%',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      footer: Text(
        footer,
        style: getBlackTitle(context),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.blueGrey,
    );
  }
}
