import 'package:RoadSideAssistance/Payment/Checkout.dart';
import 'package:RoadSideAssistance/Payment/pay.dart';
import 'package:RoadSideAssistance/Payment/payment-service.dart';
import 'package:RoadSideAssistance/components/bottom_button.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:RoadSideAssistance/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final _formKey = GlobalKey<FormState>();

class DetailsView extends StatefulWidget {
  final DocumentSnapshot post;

  DetailsView({this.post});
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  double _ratingValue;
  String _error;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("drive-steering-wheel.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(40.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(58, 66, 86, .9),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 60.0),
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        Container(
                          width: 90.0,
                          child: new Divider(color: Colors.green),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.post.data()["businessName"],
                          style: TextStyle(color: Colors.white, fontSize: 45.0),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.post.data()["address"],
                              style: TextStyle(fontSize: 16.5),
                            ),
                            Text(','),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(widget.post.data()["parish"],
                                style: TextStyle(fontSize: 16.5)),
                          ],
                        ),
                        Text(widget.post.data()["businessName"]),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  top: 60.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Text('Services Offered'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Chip(
                            label: Text(widget.post.data()["services"][0]),
                            labelStyle: TextStyle(
                                color: kActiveCardColour,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: Icon(Icons.message), onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.rate_review), onPressed: () {})
                          ],
                        ),
                      ),
                      Text("Rate Service"),
                      SizedBox(
                        height: 15.0,
                      ),
                      RatingBar(
                        itemSize: 25.0,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: Colors.amber,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        },
                      ),
                      RoundedButton(
                        Onpressed: () {
                          _openPopup(context);
                        },
                        text: 'Add Comment',
                      )
                    ],
                  ),
                ),
              ),
            ),
            BottomButton(
              buttonTitle: 'BOOK',
              onTap: () async {
                final sessionId = await Server().createCheckout();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CheckoutPage(sessionId: sessionId)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

_openPopup(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.white70,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: kActiveCardColour),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kActiveCardColour),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kActiveCardColour),
                          ),
                        ),
                        maxLines: 7,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: kActiveCardColour,
                        child: Text("Submit"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
