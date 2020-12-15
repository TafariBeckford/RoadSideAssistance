import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51HwD51B2rziuvnB3Kam1PO7vp2rEs67fM1IYYaz4yDMIDg3DmrHxqGZ1ylnsPYX8wXT1XZlNs6CSdgmUZZxzx6qk00meivNf7q';
  static const priceId = 'price_1HyRVjB2rziuvnB3pwHbRY5I';
  static String publishableKey =
      "pk_test_51HwD51B2rziuvnB3KSvE4pwesHNGTCPJRvKHYRrLR7idiNqfH9QEl4O2DTh5HjgGO2W8XgkJGN6AeNlBtVS5qLPI00dV4uHJeN";
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HwD51B2rziuvnB3KSvE4pwesHNGTCPJRvKHYRrLR7idiNqfH9QEl4O2DTh5HjgGO2W8XgkJGN6AeNlBtVS5qLPI00dV4uHJeN",
        merchantId: "Test",
        androidPayMode: 'test'));
  }
/* 
  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: false);
      }
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed:${err.toString()}', success: true);
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'CreditCardForm'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user:${err.toString()}');
    }
    return null;
  } */
}
