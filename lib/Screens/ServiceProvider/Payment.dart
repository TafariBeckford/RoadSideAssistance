/* import 'package:RoadSideAssistance/Service/payment-service.dart';
import 'package:RoadSideAssistance/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:RoadSideAssistance/Service/payment-service.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

/*   @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    StripeService.init();
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardBgColor: Colors.black,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                height: 200,
                textStyle: TextStyle(color: Colors.yellowAccent),
                showBackView: isCvvFocused,
              ),
              OutlineButton(
                onPressed: () async {
                  var response = await StripeService.payWithNewCard(
                      amount: '15000', currency: 'USD');
                  if (response.success == true) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(response.message),
                      duration: new Duration(
                          milliseconds: response.success == true ? 1200 : 3000),
                    ));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Proceed To Pay',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  /* void confirmPayment() async {
    var response =
        await StripeService.payWithCard(amount: '15000', currency: 'USD');
    if (response.success == true) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(
            content: Text(response.message),
            duration: new Duration(
                milliseconds: response.success == true ? 1200 : 3000),
          ))
          .closed
          .then((value) => Navigator.pop(context));
    }
  } */
}
 */
