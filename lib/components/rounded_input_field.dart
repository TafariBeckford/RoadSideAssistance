import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/text_field_container.dart';
import 'package:RoadSideAssistance/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onChanged;
  final Function validator;
  const RoundedInputField({
    Key key,
    this.hintText,
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
