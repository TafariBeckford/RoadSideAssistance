import 'package:RoadSideAssistance/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/Service/Location.dart';

class Pending extends StatefulWidget {
  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, userSnapshot) {
          return userSnapshot.hasData
              ? ListView.builder(
                  itemCount: userSnapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot bookingData =
                        userSnapshot.data.documents[index];
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.autorenew, color: Colors.white),
                          ),
                          title: Text(
                            bookingData.data()['Customer Info'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Text(bookingData.data()['Status'],
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
