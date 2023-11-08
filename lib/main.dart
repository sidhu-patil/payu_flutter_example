import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_flutter_example/hash_service.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;
  @override
  void initState() {
    super.initState();
    _checkoutPro = PayUCheckoutProFlutter(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayU Checkout Pro'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Start Payment"),
            onPressed: () async {
              _checkoutPro.openCheckoutScreen(payUPaymentParams: {
                PayUPaymentParamKey.key: "",
                PayUPaymentParamKey.amount: "10",
                PayUPaymentParamKey.productInfo: "Payu",
                PayUPaymentParamKey.firstName: "Sidhu Patil",
                PayUPaymentParamKey.email: "abc@gmail.com",
                PayUPaymentParamKey.phone: "9876543210",
                PayUPaymentParamKey.environment: "0",
                // String - "0" for Production and "1" for Test
                PayUPaymentParamKey.transactionId: "abc1234567982",
                // transactionId Cannot be null or empty and should be unique for each transaction. Maximum allowed length is 25 characters. It cannot contain special characters like: -_/
                PayUPaymentParamKey.userCredential: ":1000",
                //  Format: <merchantKey>:<userId> ... UserId is any id/email/phone number to uniquely identify the user.

                PayUPaymentParamKey.android_surl:
                    "https:///www.payumoney.com/mobileapp/payumoney/success.php",
                PayUPaymentParamKey.android_furl:
                    "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
                PayUPaymentParamKey.ios_surl:
                    "https:///www.payumoney.com/mobileapp/payumoney/success.php",
                PayUPaymentParamKey.ios_furl:
                    "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
              }, payUCheckoutProConfig: {
                PayUCheckoutProConfigKeys.merchantName: "PayU",
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  generateHash(Map response) async {
    // Method 1 :
    Map hashResponse = HashService.generateHash(response);
    _checkoutPro.hashGenerated(hash: hashResponse);

    // Method 2 :
    // HttpResponse httpResponse = await HttpRequests.post(
    //     'https://www.suank.in/..../hash.php', // your url
    //     data: Map<String, String>.from(response));
    // Map hashResponse = httpResponse.json;
    // _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onPaymentSuccess(dynamic response) {
    log(response.toString());
  }

  @override
  onPaymentFailure(dynamic response) {
    log(response.toString());
  }

  @override
  onPaymentCancel(dynamic response) {
    log(response.toString());
  }

  @override
  onError(dynamic response) {
    log(response.toString());
  }
}
