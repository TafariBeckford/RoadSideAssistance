import 'package:RoadSideAssistance/constants.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/Screens/Login/login_screen.dart';
import 'package:RoadSideAssistance/Screens/Signup/components/background.dart';
import 'package:RoadSideAssistance/components/already_have_an_account_acheck.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:RoadSideAssistance/components/rounded_input_field.dart';
import 'package:RoadSideAssistance/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:RoadSideAssistance/Service/Data.dart';
import 'package:RoadSideAssistance/components/loader.dart';

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
  String role;
  String gender;
  bool isLoading = false;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Loading()
        : Scaffold(
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
                    /*  SvgPicture.asset(
                "assets/icons/",
                height: size.height * 0.35,
              ), */
                    RoundedInputField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide your full name';
                        }
                      },
                      hintText: "Your Full Name",
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: size.width * 0.8,
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_drop_down),
                          decoration: InputDecoration(
                            labelText: 'Select Role',
                            icon: Icon(
                              Icons.person_pin_circle,
                              color: kActiveCardColour,
                            ),
                          ),
                          elevation: 5,
                          isExpanded: true,
                          style: TextStyle(
                              color: kActiveCardColour, fontSize: 15.0),
                          value: role,
                          items: ["Customer", "Service Provider"]
                              .map(
                                (label) => DropdownMenuItem(
                                  child: Text(label),
                                  value: label,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => role = value);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: size.width * 0.8,
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_drop_down),
                          decoration: InputDecoration(
                            labelText: 'Select Gender',
                            icon: Icon(
                              Icons.person_pin_circle,
                              color: kActiveCardColour,
                            ),
                          ),
                          elevation: 5,
                          isExpanded: true,
                          style: TextStyle(
                              fontSize: 15.0, color: kActiveCardColour),
                          value: gender,
                          items: ["Male", "Female"]
                              .map(
                                (label) => DropdownMenuItem(
                                  child: Text(label),
                                  value: label,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => gender = value);
                          },
                        ),
                      ),
                    ),
                    RoundedButton(
                      text: "SIGNUP",
                      Onpressed: () async {
                        if (_formKey.currentState.validate()) {
                          // ignore: non_constant_identifier_names
                          setState(() {
                            isLoading = true;
                          });
                          // ignore: non_constant_identifier_names
                          dynamic NewUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          User user = NewUser.user;
                          await Data(uid: user.uid)
                              .userData(fullname, role, gender);
                          if (NewUser != null) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        } else {
                          print('Form is invalid');
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
                    /*  OrDivider(),
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
              ) */
                  ],
                ),
              ),
            ),
          ));
  }
}
