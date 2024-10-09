import 'package:flutter/material.dart';
//import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
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
