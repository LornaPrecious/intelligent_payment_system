import 'package:flutter/material.dart';
import '../pages/payment_page.dart';
import '../pages/login_page.dart';
import "../components/my_textfield.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import '../pages/home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

//text editing controllers
//text editing controllers
final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _RegistrationPageState extends State<RegistrationPage> {
  final ImagePicker picker =
      ImagePicker(); //variable picker of object imagepicker
  File? _image; //variable users can store their image 'file'
  chooseImages() async {
    //Method to choose an image
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

  captureImages() async {
    //Method to choose an image
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
  //

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //if  image file is not null (has an image) display it, else display the default logo
          _image != null
              ? Image.file(_image!)
              : Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Image.asset(
                    "images/logo.png",
                    width: screenWidth - 40,
                    height: screenWidth - 40,
                  )),
          ElevatedButton(
              onPressed: () {
                chooseImages(); //callling the chooseImages method
              },
              onLongPress: () {
                //pressing for 3 or 4 seconds
                captureImages(); //calling the captureImages method
              },
              child: const Text("Choose/capture")),

          // firstname
          MyTextField(
            controller: usernameController,
            hintText: 'First name',
            obscureText: false,
          ),
          const SizedBox(height: 15),
          // lastname
          MyTextField(
            controller: usernameController,
            hintText: 'Last name',
            obscureText: false,
          ),
          const SizedBox(height: 15),
          // email address
          MyTextField(
            controller: passwordController,
            hintText: 'Email adress',
            obscureText: true,
          ),
          //password
          MyTextField(
            controller: passwordController,
            hintText: 'Create password',
            obscureText: true,
          ),

          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()));
                  },
                  style: ElevatedButton.styleFrom(
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
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
