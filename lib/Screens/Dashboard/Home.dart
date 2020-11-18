import 'package:RoadSideAssistance/Screens/Dashboard/admin_dash.dart';
import 'package:RoadSideAssistance/Screens/Dashboard/customer_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoleRouting extends StatelessWidget {
  const RoleRouting({Key key, this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkUserRole(snapshot.data);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  checkUserRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data()['role'] == 'Service Provider') {
      return ServiceProvidorDashboard();
    } else {
      return CustomerDashboard();
    }
  }
}
