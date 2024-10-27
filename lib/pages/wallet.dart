import 'dart:io';
import 'package:pay/pay.dart';
import '../services/payment_configuration.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_payment_system/pages/login_page.dart';
//import 'package:intelligent_payment_system/services/apple_pay.dart';
import '../services/stripe_service.dart';
import 'package:local_auth/local_auth.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  //final User? user;

  @override
  State<WalletPage> createState() => _WalletPageState();
}
/*
Baby blue: Color.fromARGB(1, 212, 241, 244)
Blue green: Color.fromARGB(1,117,230,218)
Blue Grotto: Color.fromARGB(1,24,154,180)
Navy Blue: Color.fromARGB(1,5,68,94)

*/

class _WalletPageState extends State<WalletPage> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false; //varible to check if user is authenticated

  String os = Platform.operatingSystem;
  bool useStripe = true;
  static const _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    // Handle Google Pay result here
    print("Google Pay Payment Result: $paymentResult");
  }

  void onApplePayResult(paymentResult) {
    // Handle Apple Pay result here
    print("Apple Pay Payment Result: $paymentResult");
  }

  Widget googleApplePayButton() {
    //if (_isAuthenticated) {
    if (Platform.isIOS) {
      return ApplePayButton(
          paymentConfiguration:
              PaymentConfiguration.fromJsonString(defaultApplePay),
          paymentItems:
              _paymentItems, ////How do I make payment item 'dynamic', ie. user determines what they are paying for & amount,
          style: ApplePayButtonStyle.whiteOutline,
          //width: ,
          margin: const EdgeInsets.only(top: 15.0),
          onPaymentResult: onApplePayResult,
          loadingIndicator: const Center(child: CircularProgressIndicator()));
    } else {
      return GooglePayButton(
        paymentConfiguration: defaultGooglePayConfig,
        paymentItems: _paymentItems,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.all(40),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //}else {
    //print("Please Authenticate!");
    //}
  }

  Future<void> _authenticate(bool useStripe) async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      if (canAuthenticateWithBiometrics) {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to make payment ',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        setState(() {
          _isAuthenticated = didAuthenticate;
        });

        if (_isAuthenticated) {
          if (useStripe) {
            // Process Stripe payment
            StripeService.instance.makePayment();
          } else {
            if (mounted) {
              showModalBottomSheet(
                backgroundColor: Colors.blue[900],
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) {
                  return Platform.isIOS
                      ? ApplePayButton(
                          paymentConfiguration: defaultApplePayConfig,
                          paymentItems: _paymentItems,
                          style: ApplePayButtonStyle.black,
                          margin: const EdgeInsets.all(70),
                          onPaymentResult: onApplePayResult,
                          loadingIndicator:
                              const Center(child: CircularProgressIndicator()))
                      : GooglePayButton(
                          paymentConfiguration: defaultGooglePayConfig,
                          paymentItems: _paymentItems,
                          type: GooglePayButtonType.pay,
                          margin: const EdgeInsets.all(70),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                },
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please authenticate to proceed with payment"),
              duration: Duration(seconds: 2),
            ));
          }
        }
      }
    } catch (e) {
      // Handle error
      print("Authentication error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Authentication error. Please try again."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          title: Text('Wallet'),
          centerTitle: true,
        ),
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App's Cash Section
                Card(
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cash',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ksh 0.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Add funds functionality
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Add Funds'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Payment Methods Section
                Text(
                  'Make payment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                //Stripe
                ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Pay with card',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      //Icons.atm,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      _authenticate(useStripe);
                    }),
                //tileColor: ,
                //selectedTileColor: Color(value)
                //Google/Apple pay
                ListTile(
                  leading: Icon(
                    Icons.money,
                    color: Colors.blue,
                  ),
                  title: Text(
                    Platform.isIOS ? 'Apple Pay' : 'Google Pay',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _authenticate(useStripe = false);
                  },
                ),
                /*
                ElevatedButton(
                  onPressed: () {
                    // Add payment functionality
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('+ Add payment method'),
                ),
                SizedBox(height: 24), */

                // Ride Profiles Section
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Personal',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Personal profile tap
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Purchase History',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Previous payments',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    // History purchases
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
