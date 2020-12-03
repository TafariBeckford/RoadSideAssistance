import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/text_field_container.dart';
import 'package:RoadSideAssistance/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final Function onChanged;
  final Function validator;
  const RoundedPasswordField({
    Key key,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: kActiveCardColour),
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kActiveCardColour,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
