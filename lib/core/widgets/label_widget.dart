import 'package:flutter/material.dart';
import 'package:to_do_app/core/utilities/styles.dart';

class LabelWidget extends StatelessWidget {
  final double? defWidth;
  final String defText;

  const LabelWidget({super.key, this.defWidth = 200.0, required this.defText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        color: Colors.amber,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            child: Container(
              height: 100,
              width: defWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Center(child: Text(
                defText,
                style: getBlueGreyTitle(context),
              ),),
            ),
          ),
        ],
      ),
    );
  }
}

