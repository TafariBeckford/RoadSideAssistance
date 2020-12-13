import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/Screens/Login/components/background.dart';
import 'package:RoadSideAssistance/Screens/Signup/signup_screen.dart';
import 'package:RoadSideAssistance/components/already_have_an_account_acheck.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:RoadSideAssistance/components/rounded_input_field.dart';
import 'package:RoadSideAssistance/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:RoadSideAssistance/Home.dart';
import 'package:RoadSideAssistance/components/loader.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '_screen.dart';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading ? Loading():Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/New towing.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
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
                    if (input.isEmpty) {
                      return 'Provide an password';
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  Onpressed: () {
                    formLogin();
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void formLogin() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        User user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
        if (user != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RoleRouting(user: user)));
        } else {
          setState(() {
            isLoading = false;
            return LoginScreen();
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
