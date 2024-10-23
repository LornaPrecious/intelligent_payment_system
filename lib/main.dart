import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../pages/consts.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //being able to move from one page to the other

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // routes: {'/homepage': (context) => WalletScreen()},
      home:
          RegistrationPage(), //used this line of code to display homepage from previous tutorial
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
