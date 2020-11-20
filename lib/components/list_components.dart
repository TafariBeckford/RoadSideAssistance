import 'package:flutter/material.dart';

//Top App Bar
final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text('Lessons'),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () {},
    )
  ],
);

//Bottom App Bar
final Bottombar = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Color.fromRGBO(58, 66, 86, 1.0),
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