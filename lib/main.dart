import 'package:RoadSideAssistance/Screens/Login/login_screen.dart';
import 'package:RoadSideAssistance/Screens/ServiceProvider/pending.dart';
import 'package:RoadSideAssistance/Service/Location.dart';
import 'package:RoadSideAssistance/StripePayment/ExisitngCard.dart';
import 'package:RoadSideAssistance/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RoadSide Assistance',
        theme: ThemeData.dark().copyWith(
          canvasColor: Colors.white,
          primaryColor: kActiveCardColour,
          hintColor: kActiveCardColour,
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        home: LoginScreen(),
        routes: {
          //'/new-card': (context) => NewCardPage(),
          '/existing-cards': (context) => ExistingCardsPage()
        });
  }
}
