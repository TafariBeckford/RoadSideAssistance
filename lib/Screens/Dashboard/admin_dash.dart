import 'package:RoadSideAssistance/Screens/Dashboard/completed.dart';
import 'package:RoadSideAssistance/Screens/Dashboard/open.dart';
import 'package:RoadSideAssistance/Screens/Dashboard/pending.dart';
import 'package:RoadSideAssistance/constants.dart';
import 'package:flutter/material.dart';

class ServiceProviderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Service Provider Dashboard'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                  Navigator.pop(context);
                },
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            backgroundColor: kInActiveColour,
            elevation: 0,
            bottom: TabBar(
                labelColor: kActiveCardColour,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("OPEN"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("PENDING"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("COMPLETED"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Icon(Icons.lock_open),
            Icon(Icons.hourglass_empty),
            Icon(Icons.lock),
          ]),
        ),
      ),
    );
  }
}
