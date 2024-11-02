import "package:flutter/material.dart";
import "package:intelligent_payment_system/components/password_textfield.dart";
import "package:intelligent_payment_system/pages/forgot_password.dart";
import "package:intelligent_payment_system/services/auth_services.dart";
import "../components/my_textfield.dart";

import '../pages/sign_up_page.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false; //varible to check if user is authenticated
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future loginUser() async {
    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

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
      } else {
        setState(() {
          _isAuthenticated = false; //toggle the authentication state
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Biometrics failed! Please try again"),
            duration: Duration(seconds: 2),
          ));
        }
      }
    } catch (e) {
      // Handle error
      print("Authentication error: $e");
    }
  }

/*
  void _navigateToPaymentPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WalletPage(),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: false, //check what this is
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
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
                  hintText: 'Email',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                //password
                MyPasswordTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  filled: true,
                ),
                const SizedBox(height: 15),
                //forgot password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        child: Text(
                          "Forgot Password",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //signin button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                    _authenticate();
                    loginUser();
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
                                    builder: (context) =>
                                        const RegistrationPage(
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
      ),
    );
  }
}
