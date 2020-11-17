import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/Screens/Login/login_screen.dart';
import 'package:RoadSideAssistance/Screens/Signup/components/background.dart';
import 'package:RoadSideAssistance/Screens/Signup/components/or_divider.dart';
import 'package:RoadSideAssistance/Screens/Signup/components/social_icon.dart';
import 'package:RoadSideAssistance/components/already_have_an_account_acheck.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:RoadSideAssistance/components/rounded_input_field.dart';
import 'package:RoadSideAssistance/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen.dart';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String fullname;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your FullName",
                onChanged: (value) {
                  fullname = value;
                },
              ),
              RoundedInputField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide an email';
                  }
                },
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Longer password please';
                  }
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                Onpressed: () async {
                  final FormState form = _formKey.currentState;
                  if (form.validate()) {
                    print('Form is valid');
                  } else {
                    print('Form is invalid');
                  }
                  try {
                    final NewUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    User user = NewUser.user;
                    await Data(uid: user.uid).userData(fullname);
                    if (NewUser != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class Data {
  final String uid;
  Data({this.uid});
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('users');
  Future userData(String fullname) async {
    return await UserCollection.doc(uid).set({'fullname': fullname});
  }
}
