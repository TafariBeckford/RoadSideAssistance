import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/list_components.dart';

import '../SPdeatails.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("serviceprovider").get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsView(post: post),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child: ListTile(
                      onTap: () => navigateToDetail(snapshot.data[index]),
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
                              snapshot.data[index].data()['Images'][0],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data[index].data()['businessName'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.linear_scale,
                              color: Colors.yellowAccent),
                          Text(
                            snapshot.data[index].data()['address'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(','),
                          Text(
                            snapshot.data[index].data()['parish'],
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      
    );
  }
}
