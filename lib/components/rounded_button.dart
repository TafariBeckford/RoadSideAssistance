import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  // ignore: non_constant_identifier_names
  final Function Onpressed;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    // ignore: non_constant_identifier_names
    this.Onpressed,
    this.color = Colors.white,
    this.textColor = kActiveCardColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: Onpressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
