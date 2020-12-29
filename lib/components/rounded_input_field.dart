import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/text_field_container.dart';
import 'package:RoadSideAssistance/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final bool expands;
  final List inputFormatters;
  const RoundedInputField({
    Key key,
    this.expands,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLines,
    this.inputFormatters,
    this.icon = Icons.person,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: kActiveCardColour),
        validator: validator,
        onChanged: onChanged,
        cursorColor: kActiveCardColour,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kActiveCardColour,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
