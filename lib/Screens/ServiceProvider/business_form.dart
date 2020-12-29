import 'dart:io';
import 'package:RoadSideAssistance/Service/Booking.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:RoadSideAssistance/components/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:RoadSideAssistance/constants.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

User user = FirebaseAuth.instance.currentUser;
final _inputController = TextEditingController();
class BusinessForm extends StatefulWidget {
  BusinessForm({Key key}) : super(key: key);

  @override
  _BusinessFormState createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  File _image;
  final picker = ImagePicker();
  DocumentReference sightingRef =
      FirebaseFirestore.instance.collection("serviceprovider").doc();

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: kActiveCardColour,
                      ),
                      title: new Text(
                        'Gallery',
                        style: TextStyle(color: kActiveCardColour),
                      ),
                      onTap: () {
                        getGalleryImage();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: kActiveCardColour,
                    ),
                    title: new Text(
                      'Camera',
                      style: TextStyle(color: kActiveCardColour),
                    ),
                    onTap: () {
                      getCameraImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  // ignore: override_on_non_overriding_member
  List _myActivities;
  String _myActivitiesResult;
  String parish;
  String businessName;
  String phoneNumber;
  String address;

  List<String> parishList = [
    "Kingston",
    "St.Andrew",
    "Portland",
    "St.Thomas",
    "St.Catherine",
    "St.Mary",
    "St.Ann",
    "Manchester",
    "Clarendon",
    "St.Elizabeth",
    "Westmoreland",
    "Hanover",
    "St.James",
    "Trelawny",
  ];
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  Future<void> saveData(File _image, DocumentReference ref) async {
    String imageURL = await uploadFile(_image);
    Map<String, dynamic> spData = {
      "Images": FieldValue.arrayUnion([imageURL]),
      'parish': parish,
      'businessName': businessName,
      'phoneNumber': int.parse(this.phoneNumber),
      'address': address,
      'services': _myActivities,
      'userId': user.uid,
    };
    ref.set(spData);
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('SPlogo/${Path.basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => print('File Uploaded'));
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(95),
                            ),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              RoundedInputField(
                
                hintText: 'Business Name',
              
                icon: Icons.business,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  businessName = value;
                },
              ),
              RoundedInputField(
                hintText: 'Telephone Number',
                icon: Icons.call,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
              RoundedInputField(
                hintText: 'Address',
                icon: Icons.home,
                keyboardType: TextInputType.streetAddress,
                maxLines: null,
                onChanged: (value) {
                  address = value;
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
                      labelText: 'Select Parish',
                      icon: Icon(
                        Icons.place,
                        color: kActiveCardColour,
                      ),
                    ),
                    elevation: 5,
                    isExpanded: true,
                    style: TextStyle(color: kActiveCardColour, fontSize: 15.0),
                    value: parish,
                    items: parishList
                        .map(
                          (label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => parish = value);
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
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: MultiSelectFormField(
                        fillColor: Colors.white,
                        autovalidate: false,
                        chipBackGroundColor: kActiveCardColour,
                        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        checkBoxActiveColor: kActiveCardColour,
                        checkBoxCheckColor: Colors.white,
                        dialogShapeBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        title: Text(
                          "Select Services Offered",
                          style:
                              TextStyle(fontSize: 16, color: kActiveCardColour),
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return "Please select one or more options";
                          }
                        },
                        dataSource: [
                          {
                            "display": "Towing",
                            "value": "Towing",
                          },
                          {
                            "display": "Dead Battery",
                            "value": "Dead Battery",
                          },
                          {
                            "display": "Engine Oil",
                            "value": "Engine Oil",
                          },
                          {
                            "display": "Flat Tyre",
                            "value": "Flat Tyre",
                          },
                          {
                            "display": "Low Fuel",
                            "value": "Low Fuel",
                          },
                          {
                            "display": "Breakdown",
                            "value": "Breakdown",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        hintWidget: Text(
                          'Please choose one or more',
                          style: TextStyle(color: kActiveCardColour),
                        ),
                        initialValue: _myActivities,
                        onSaved: (value) {
                          _myActivities = value;
                        }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              ),
              RoundedButton(
                text: 'SUBMIT',
                Onpressed: () {
                  saveData(_image, sightingRef);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
