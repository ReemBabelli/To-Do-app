import 'package:flutter/material.dart';
import 'package:to_do_app/core/utilities/styles.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;

  const ErrorMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child:Center(
        child:  Text(message , style:  getBlackTitle(context),),
      ),
    );
  }
}