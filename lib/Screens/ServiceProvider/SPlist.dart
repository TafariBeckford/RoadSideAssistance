import 'package:RoadSideAssistance/Screens/ServiceProvider/SPdeatails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/list_components.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('serviceprovider')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsView(
                                    post: snapshot.data(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                    border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    child: ClipOval(
                                        child: Image.network(
                                            document.data()['Images'])),
                                  ),
                                ),
                                title: Text(
                                  document['busninessName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Colors.yellowAccent),
                                    Text(
                                      document['address'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(','),
                                    Text(
                                      document['parish'],
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white, size: 30.0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: Bottombar,
    );
  }
}
