import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

final _auth = FirebaseAuth.instance;
final databaseReference = FirebaseFirestore.instance;
User user = FirebaseAuth.instance.currentUser;
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress;


_getCurrentLocation() {
  geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    _currentPosition = position;

    _getAddressFromLatLng();
  }).catchError((e) {
    print(e);
  });
}

Future _getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark place = p[0];

    _currentAddress =
        "${place.locality}, ${place.name}, ${place.subThoroughfare}";
    print(_currentAddress);
  } catch (e) {
    print(e);
  }
}

void addBooking() async {
  DocumentReference ref = await databaseReference.collection("bookings").add(
    {
      'Customer Info': user.email,
      'UserId': user.uid,
      'Status': 'Pending',
      'BookingDate': DateTime.now(),
      'Location': _currentAddress
    },
  );
}
