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
      backgroundColor: Colors.blue[50],
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
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                filled: true,
              ),
              const SizedBox(height: 15),
              //password
              MyTextField(
                  controller: passwordController,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentPage(
                                user: LocalDB.getUser(),
                              )));
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
                      padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.black),
                      )),
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
                          color: Colors.blue[900], fontWeight: FontWeight.w600),
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
