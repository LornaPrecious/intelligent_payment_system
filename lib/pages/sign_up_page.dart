import 'package:flutter/material.dart';
import 'package:intelligent_payment_system/components/password_textfield.dart';
import 'package:intelligent_payment_system/pages/wallet.dart';
import 'package:intelligent_payment_system/models/user.dart';
import 'package:intelligent_payment_system/services/auth_services.dart';
import '../pages/login_page.dart';
import "../components/my_textfield.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import '../services/registration_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  // final User? user;
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

//text editing controllers
//text editing controllers

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  UserModel? userModel;

  Future<void> registerUser() async {
    try {
      if (_passwordController.text == _confirmpasswordController.text) {
        await _authService.registerWithEmailAndPassword(
          _usernameController.text,
          _fullnameController.text,
          _emailController.text,
          _phonenumberController.text,
          _addressController.text,
          _passwordController.text,
        );
        // Check if still mounted after async call
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration successful")),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match, Please try again!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  late ImagePicker picker =
      ImagePicker(); //variable picker of object imagepicker
  File? _image; //variable users can store their image 'file'

  //Method to choose an image from gallery
  chooseImages() async {
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery); //geting image from gallery
    if (image != null) {
      //user has sellected an image
      setState(() {
        //update the gui
        _image = File(image.path); //get image path
      });
    }
  }

  //Method to capture an image using camera
  captureImages() async {
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera); //geting image from camera
    if (image != null) {
      //user has sellected an image
      setState(() {
        //update the gui
        _image = File(image.path); //get image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.blue[50],
        resizeToAvoidBottomInset: false, //check what this is
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //logo
                //SquareTile(imagePath: "images/journey_ai_writing_logo.jpeg"),
                // const SizedBox(height: ),
                //if  image file is not null (has an image) display it, else display the default logo
                _image != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: screenWidth - 30,
                        height: screenWidth - 30,
                        child: Image.file(_image!),
                      ) //Container to display user's image, else display default logo
                    : Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          "images/logo.png",
                          width: screenWidth - 20,
                          height: screenWidth - 20,
                        )),
                ElevatedButton(
                  onPressed: () {
                    chooseImages(); //callling the chooseImages method
                  },
                  onLongPress: () {
                    //pressing for 3 or 4 seconds
                    captureImages(); //calling the captureImages method
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900],
                  ),
                  child: const Text("Choose/capture face"),
                ),
                const SizedBox(height: 15),

                // firstname
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                // lastname
                MyTextField(
                  controller: _fullnameController,
                  hintText: 'Full name',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15),
                // email address
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                MyTextField(
                  controller: _phonenumberController,
                  hintText: 'Phone number',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),

                MyTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  obscureText: false,
                  filled: true,
                  keyboardType: TextInputType.text,
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
                MyPasswordTextField(
                  controller: _confirmpasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                  filled: true,
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          /*if (_image != null) {
                          //await doFaceDetection();
                        } */
                          if (_formKey.currentState?.validate() ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Processing Data'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            await registerUser();
                            if (mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WalletPage()));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            minimumSize: Size(screenWidth - 30, 50)),
                        child: const Text("Sign up"),
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Already a member?",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 7.5,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the login page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
