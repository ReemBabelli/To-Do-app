import 'package:flutter/material.dart';
import 'package:to_do_app/core/utilities/styles.dart';
class TextFieldWidget extends StatefulWidget {

  final String defText;
  final Widget? defIconSuf;
  final Widget? defIconPref;
  final double? defWidth;
  final double? defHeight;
  final int ? defMinLines;
  final int ? defMaxLines;
  final TextInputType?  defKey;
  final void Function()? defOnTap;
  final void Function(String)? defOnChanged;
  final String? Function(String?)? defValidator;
  final TextEditingController defController;
  final bool defObs;
  final bool defEnabled;

  const TextFieldWidget({Key? key,
    required this.defText,
    this.defIconSuf,
     this.defIconPref,
    this.defWidth = double.infinity,
    this.defHeight = 35.0,
    this.defKey,
    this.defOnTap,
    this.defOnChanged,
    this.defValidator,
    required this.defController,
    this.defObs = false,
    this.defEnabled = true,
    this.defMinLines,
    this.defMaxLines = 1,
  })
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.defWidth,
      height:widget.defHeight ,
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: getBlueGreyText(context),
          labelText: widget.defText,
          border:const OutlineInputBorder(),
          prefixIcon: widget.defIconPref,
          suffixIcon: widget.defIconSuf,
        ),
        keyboardType: widget.defKey,
        onChanged: widget.defOnChanged,
        onTap: widget.defOnTap,
        obscureText: widget.defObs,
        controller: widget.defController,
        validator: widget.defValidator,
        enabled:widget.defEnabled ,
        minLines: widget.defMinLines,
        maxLines: widget.defMaxLines,


      ),
    );
  }
}
