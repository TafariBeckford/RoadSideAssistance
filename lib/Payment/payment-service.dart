
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  //static String apiBase = 'https://api.stripe.com/v1';
  //static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51HwD51B2rziuvnB3Kam1PO7vp2rEs67fM1IYYaz4yDMIDg3DmrHxqGZ1ylnsPYX8wXT1XZlNs6CSdgmUZZxzx6qk00meivNf7q';

  static const priceId = 'price_1HyRVjB2rziuvnB3pwHbRY5I';
  static String publishableKey =
      'pk_test_51HwD51B2rziuvnB3KSvE4pwesHNGTCPJRvKHYRrLR7idiNqfH9QEl4O2DTh5HjgGO2W8XgkJGN6AeNlBtVS5qLPI00dV4uHJeN';

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
}
