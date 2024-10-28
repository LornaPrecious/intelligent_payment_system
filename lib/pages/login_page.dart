import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:intelligent_payment_system/pages/wallet.dart";
import "package:intelligent_payment_system/services/auth_services.dart";
//import "package:intelligent_payment_system/models/user.dart";
//import "package:intelligent_payment_system/utils/utils.dart";
//import "../pages/payment_page.dart";
//import "../utils/local_db.dart";
import "../components/my_textfield.dart";
//import "../components/square_tile.dart";
import '../pages/sign_up_page.dart';
import 'package:local_auth/local_auth.dart';
import '../models/user.dart';

//import '../pages/home_page.dart';
//import '../pages/sign_up_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  //final User? user;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false; //varible to check if user is authenticated

  final AuthService _authService = AuthService();
  //text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserModel? userModel;

  void loginUser() async {
    User? user = await _authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      userModel = await _authService.getUserDetails(user.uid);
      setState(() {});
    }
  }
  // sign user in method
  /*
  @override
  void initState() {
    printIfDebug(
        LocalDB.getUser().name); //check if user is not null/ if registred
    super.initState(); 
  } */

  Future<void> _authenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      if (canAuthenticateWithBiometrics) {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to log in',
          options: const AuthenticationOptions(biometricOnly: false),
        );
        setState(() {
          _isAuthenticated = didAuthenticate;
        });

        if (_isAuthenticated) {
          _navigateToPaymentPage();
        }
      }
    } catch (e) {
      // Handle error
      print("Authentication error: $e");
    }
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WalletPage(
            //user: LocalDB.getUser(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: false, //check what this is
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //const SizedBox(height: 60),
              //logo
              Image.asset(
                "images/journey_ai_writing_logo_nobg_cropped.png",
                width: screenWidth - 100,
                height: screenWidth - 100,
              ),
              //SquareTile(imagePath: "images/journey_ai_writing_logo.jpeg"),
              //const SizedBox(height: 60),
              //welcome back ,
              Text(
                "Welcome back",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              // username
              MyTextField(
                controller: _emailController,
                hintText: 'Username',
                obscureText: false,
                filled: true,
              ),
              const SizedBox(height: 15),
              //password
              MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  filled: true),
              const SizedBox(height: 15),
              //forgot password
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //signin button
              ElevatedButton(
                onPressed: () {
                  _authenticate();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900],
                    minimumSize: Size(screenWidth - 30, 50)),
                child: const Text("Login"),
              ),

              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: .5,
                        color: Colors.cyan,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Or continue With",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: .5,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // apple Button
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.apple, // Apple icon
                        // Set the color of the icon
                        size: 60, // Set the size of the icon
                      ),
                    ),
                    //google Button
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.g_mobiledata, // Apple icon
                        // Set the color of the icon
                        size: 70, // Set the size of the icon
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 25, 0, 10),
                      child: Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    width: 7.5,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the registration page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegistrationPage(
                                      // user: LocalDB.getUser(),
                                      )),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ]))
                ],
              )

              //not a member register
            ],
          ),
        ),
      ),
    );
  }
}
