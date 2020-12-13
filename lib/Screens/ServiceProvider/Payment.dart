import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:RoadSideAssistance/Model/payment-service.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String cardNumber = '44242424242424242';
  String expiryDate = '04/24';
  String cardHolderName = 'Tafari Beckford';
  String cvvCode = '424';

  bool isCvvFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () async {
                    var response = await StripeService.payWithCard(
                        amount: '15000', currency: 'USD');
                    if (response.success == true) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(
                            content: Text(response.message),
                            duration: new Duration(
                                milliseconds:
                                    response.success == true ? 1200 : 3000),
                          ))
                          .closed
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  child: CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardBgColor: Colors.black,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    //height: 175,
                    textStyle: TextStyle(color: Colors.yellowAccent),
                    showBackView: isCvvFocused,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    themeColor: Colors.red,
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              )
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
}
