import "package:flutter/material.dart";
import "package:intelligent_payment_system/models/user.dart";
import "package:intelligent_payment_system/utils/utils.dart";
import "../pages/payment_page.dart";
import "../utils/local_db.dart";
import "../components/my_textfield.dart";
import "../components/square_tile.dart";
import '../pages/sign_up_page.dart';

//import '../pages/home_page.dart';
//import '../pages/sign_up_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.user});

  final User? user;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  @override
  void initState() {
    printIfDebug(
        LocalDB.getUser().name); //check if user is not null/ if registred
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFB2BEC3),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              //logo
              SquareTile(imagePath: "images/logo3.png"),
              const SizedBox(height: 60),
              //welcome back ,
              const Text(
                "Welcome back",
                style: TextStyle(
                  color: Color(0xFFD63031),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              // username
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentPage(
                                user: LocalDB.getUser(),
                              )));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth - 30, 50)),
                child: const Text("Sign in"),
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
                          color: Colors.red,
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
              const Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google Button
                    SquareTile(imagePath: "images/apple-logo.png"),

                    SizedBox(
                      width: 15,
                    ),
                    //apple Button
                    SquareTile(imagePath: "images/google-logo.png")
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 7.5,
                  ),
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
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
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
