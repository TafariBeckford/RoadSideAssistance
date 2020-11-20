import 'package:flutter/material.dart';

final levelIndicator = Container(
  child: Container(
    child: LinearProgressIndicator(
        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
        //value: lesson.indicatorValue,
        valueColor: AlwaysStoppedAnimation(Colors.green)),
  ),
);

final coursePrice = Container(
  padding: const EdgeInsets.all(7.0),
  decoration: new BoxDecoration(
      border: new Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(5.0)),
  child: new Text(
    '20',
    style: TextStyle(color: Colors.white),
  ),
);
