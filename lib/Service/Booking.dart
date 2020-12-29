import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final databaseReference = FirebaseFirestore.instance;
User user = FirebaseAuth.instance.currentUser;

void addBooking() async {
  DocumentReference ref = await databaseReference.collection("bookings").add(
    {
      'Customer Info': user.email,
      'UserId': user.uid,
      'Status': 'Pending',
      'BookingDate': DateTime.now(),
    },
  );
}
