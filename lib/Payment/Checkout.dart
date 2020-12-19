import 'dart:convert';
import 'dart:io';
import 'package:RoadSideAssistance/Payment/payment.dart';
import 'package:RoadSideAssistance/Payment/payment-service.dart';
import 'package:dio/dio.dart';

class Server {
  Future<String> createCheckout() async {
    Item item = new Item();
    item.price = StripeService.priceId;
    item.quantity = 1;

    String sKey = StripeService.secret;

    List<Item> listItem = new List<Item>();
    listItem.add(item);

    final jsonList = listItem;

    final json = jsonEncode(jsonList, toEncodable: (e) => item.toJson());
    print("This: " + json);

    final auth = 'Basic ' + base64Encode(utf8.encode('$sKey:'));
    final body = {
      'payment_method_types': ['card'],
      'line_items': [jsonList[0].toJson()],
      'mode': 'payment',
      'success_url': 'http://localhost:8080/#/success',
      'cancel_url': 'http://localhost:8080/#/cancel',
    };

    print(body);
    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      return result.data['id'];
    } on DioError catch (e) {
      print(e.response);
      throw e;
    }
  }
}
