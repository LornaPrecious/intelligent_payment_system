import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../services/payment_configuration.dart';

class ApplePay extends StatefulWidget {
  const ApplePay({super.key});

  @override
  State<ApplePay> createState() => _ApplePayState();
}

class _ApplePayState extends State<ApplePay> {
  String os = Platform.operatingSystem;

  static const _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  googleApplePay() {
    var applePayButton = ApplePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems:
          _paymentItems, ////How do I make payment item 'dynamic', ie. user determines what they are paying for & amount,
      style: ApplePayButtonStyle.black,
      //width: ,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: onApplePayResult,
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );

    var googlePayButton = GooglePayButton(
      paymentConfiguration: defaultGooglePayConfig,
      paymentItems: _paymentItems,
      type: GooglePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: onGooglePayResult,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return Platform.isIOS ? applePayButton : googlePayButton;
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        //child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
      ),
    );
  }
}
