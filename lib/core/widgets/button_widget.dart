import 'package:flutter/material.dart';
import 'package:to_do_app/core/utilities/styles.dart';
class ButtonWidget extends StatefulWidget {
  final double? defWid;
  final double? defHeight;
  final String? defText;
  final void Function()? defOnTap;

   const ButtonWidget({Key? key,
        required this.defWid,
        this.defHeight = 30.0,
        required this.defText,
        required this.defOnTap,
      })
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.defOnTap,
      child: Container(
          width: widget.defWid,
          height: widget.defHeight,
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(5.0)),
            color: Colors.blueGrey[600],
          ),
          child: Center(
              child: Text(
                widget.defText!,
                style:getWhiteText(context),
              ))),

    );
  }
}
