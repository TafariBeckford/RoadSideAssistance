import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/text_field_container.dart';
import 'package:RoadSideAssistance/constants.dart';

class RoundedTextArea extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final Function validator;
  final TextInputType keyboardType;
  final int maxLines;
  final bool expands;
  final List inputFormatters;
  const RoundedTextArea({
    Key key,
    this.expands,
    this.hintText,
    this.keyboardType,
    this.maxLines,
    this.inputFormatters,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: kActiveCardColour),
      
        onChanged: onChanged,
        cursorColor: kActiveCardColour,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
