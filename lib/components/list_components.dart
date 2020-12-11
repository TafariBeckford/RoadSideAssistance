import 'package:RoadSideAssistance/constants.dart';
import 'package:flutter/material.dart';

//Top App Bar
final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: kActiveCardColour,
  title: Text('Service Provider'),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () {},
    )
  ],
);

//Bottom App Bar
// ignore: non_constant_identifier_names
final Bottombar = Container(
  height: 55.0,
  child: BottomAppBar(
    color: kActiveCardColour,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.blur_on, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.hotel, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.account_box, color: Colors.white),
          onPressed: () {},
        )
      ],
    ),
  ),
);
