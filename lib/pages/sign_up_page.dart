//import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:intelligent_payment_system/pages/wallet.dart';
//import 'package:intelligent_payment_system/models/user.dart';
//import 'package:intelligent_payment_system/utils/local_db.dart';
import 'package:path_provider/path_provider.dart';
//import '../pages/payment_page.dart';
import '../pages/login_page.dart';
import "../components/my_textfield.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
//import "../components/square_tile.dart";

//import '../pages/home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  // final User? user;
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

//text editing controllers
//text editing controllers
final controller = TextEditingController();

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

  doFaceDetection() async {
    //PROCESSING IMAGE
    // InputImage Function(File file) inputImage;
    InputImage inputImage =
        InputImage.fromFile(_image!); //load the image to be processed
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      print('No face detected');
    } else {
      for (Face face in faces) {
        final Rect boundingBox = face.boundingBox;

        // Display detected face bounding box for testing
        print('Detected face at: $boundingBox');

        // Crop the detected face from the original image
        await cropAndSaveFace(boundingBox); //Crop and save the detected face
      }

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
      // Crop the face from the image and save it
    }
  }

  Future<void> cropAndSaveFace(Rect boundingBox) async {
    // Load the image using the image package to crop
    final img.Image? originalImage =
        img.decodeImage(await _image!.readAsBytes());

    if (originalImage == null) {
      print('Could not decode image');
      return;
    }

    // Crop the face using the bounding box
    final img.Image croppedFace = img.copyCrop(
      originalImage,
      x: boundingBox.left.toInt(),
      y: boundingBox.top.toInt(),
      width: boundingBox.width.toInt(),
      height: boundingBox.height.toInt(),
    );

    // Save the cropped face locally
    final directory = await getApplicationDocumentsDirectory();
    final facePath =
        '${directory.path}/cropped_face_${DateTime.now().millisecondsSinceEpoch}.jpg';
//Write the cropped face image
    File(facePath).writeAsBytesSync(img.encodeJpg(croppedFace));

    print('Face saved at: $facePath');

    /* 
    Security: This folder is generally protected by the operating system, and the files are not easily accessible unless the device 
    is rooted or jailbroken. However, it is not considered a high-security location. For high-security needs, you might want to use 
    the Keychain on iOS or Keystore on Android for sensitive data.

    */
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.blue[50],
        resizeToAvoidBottomInset: false, //check what this is
        body: SingleChildScrollView(
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
                controller: controller,
                hintText: 'First name',
                obscureText: false,
                filled: true,
              ),
              const SizedBox(height: 15),
              // lastname
              MyTextField(
                controller: controller,
                hintText: 'Last name',
                obscureText: false,
                filled: true,
              ),
              const SizedBox(height: 15),
              // email address
              MyTextField(
                controller: controller,
                hintText: 'Email address',
                obscureText: true,
                filled: true,
              ),
              const SizedBox(height: 15),

              MyTextField(
                controller: controller,
                hintText: 'Phone number',
                obscureText: true,
                filled: true,
              ),
              const SizedBox(height: 15),

              MyTextField(
                controller: controller,
                hintText: 'Address',
                obscureText: true,
                filled: true,
              ),
              const SizedBox(height: 15),
              //password
              MyTextField(
                controller: controller,
                hintText: 'Password',
                obscureText: true,
                filled: true,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: controller,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletPage(
                                    //user: LocalDB.getUser()
                                    )));
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
        ));
  }
}
