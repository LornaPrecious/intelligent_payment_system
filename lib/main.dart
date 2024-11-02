import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_payment_system/services/firebase_options.dart';
import 'package:intelligent_payment_system/pages/auth_wrapper.dart';
import 'package:intelligent_payment_system/pages/edit_profile.dart';
import 'package:intelligent_payment_system/pages/profile.dart';
//import 'package:intelligent_payment_system/pages/main_page.dart';
import 'package:intelligent_payment_system/pages/wallet.dart';
//import 'package:intelligent_payment_system/utils/local_db.dart';
import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'services/consts.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //being able to move from one page to the other

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment system',
      debugShowCheckedModeBanner: false,
      // routes: {'/homepage': (context) => WalletScreen()},
      home: //RegistrationPage(),
          AuthWrapper(), //used this line of code to display homepage from previous tutorial

      routes: {
        '/payment': (context) => WalletPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => RegistrationPage(),
        '/auth': (context) => AuthWrapper(),
        '/profile': (context) => ProfilePage(),
        '/edit profile': (context) => EditProfilePage(),
      },
    );
  }
}
