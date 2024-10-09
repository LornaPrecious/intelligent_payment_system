import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../pages/payment_page.dart';
import '../pages/login_page.dart';
import "../components/my_textfield.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

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
  late ImagePicker picker =
      ImagePicker(); //variable picker of object imagepicker
  File? _image; //variable users can store their image 'file'

  late FaceDetector faceDetector; //declaring the face detector
  @override
  void initState() {
    //implement initState
    super.initState();
    picker = ImagePicker();

    /// Instance id.
    final options = FaceDetectorOptions(
        performanceMode:
            FaceDetectorMode.accurate); //creating a face detector option object
    /* Various options available: Landmarks, performance mode, Tracking, Classification, min Face size etc, 
    Performance mode - can be first(if its real time) or accurate(if from pictures)*/
    faceDetector = FaceDetector(
        options:
            options); //then creating a face detector object - loading the face detector model from mlkit library

    // If face tracking was enabled with FaceDetectorOptions:
    /* if (face.trackingId != null) {
    final int? id = face.trackingId;
    } */
  }

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
  //

  doFaceDetection() async {
    //PROCESSING IMAGE
    // InputImage Function(File file) inputImage;
    InputImage inputImage = InputImage.fromFile(_image!);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      final Rect boundingBox =
          face.boundingBox; //getting the location of the face

      final double? rotX =
          face.headEulerAngleX; // Head is tilted up and down rotX degrees
      final double? rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double? rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      /* // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      if (leftEar != null) {
        final Point<int> leftEarPos = leftEar.position;
      }

      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double? smileProb = face.smilingProbability;
      } */

      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int? id = face.trackingId;
      }
    }
  }

  //remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false, //check what this is
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //if  image file is not null (has an image) display it, else display the default logo
              _image != null
                  ? Container(
                      margin: const EdgeInsets.only(top: 100),
                      width: screenWidth - 50,
                      height: screenWidth - 50,
                      child: Image.file(_image!),
                    ) //Container to display user's image, else display default logo
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
                  child: const Text("Choose/capture face image")),

              /* TWO 'CARDS' WITH ICONS FOR CAPTURE AND CHOOSE OPTIONS SEPARATELY
  Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromGallery();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.image,
                          color: Colors.blue, size: screenWidth / 7),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromCamera();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.camera,
                          color: Colors.blue, size: screenWidth / 7),
                    ),
                  ),
                )
              ],
            ),
          )

          */
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
              const SizedBox(height: 15),
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
                                color: Colors.blue,
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
        ));
  }
}
