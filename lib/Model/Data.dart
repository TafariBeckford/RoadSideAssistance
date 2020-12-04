import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String uid;
  Data({this.uid});
  // ignore: non_constant_identifier_names
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('users');
  Future userData(String fullname, String role, String gender) async {
    return await UserCollection.doc(uid)
        .set({'fullname': fullname, 'role': role, 'gender': gender});
  }
}
