/*
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'dart:math';

class FaceRegistrationPage extends StatefulWidget {
  const FaceRegistrationPage({super.key});

  @override
  State<FaceRegistrationPage> createState() => _FaceRegistrationPageState();
}

class _FaceRegistrationPageState extends State<FaceRegistrationPage> {
  // Load TFLite model
  late Interpreter interpreter;

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('mobilenet.tflite');
    print("Model loaded successfully");
  }

  // Resize and preprocess image for MobileNet model without using tflite_flutter_helper
  Uint8List preprocessImage(File imageFile) {
    // Load the image using the image package
    final img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    // MobileNet expects 224x224 images, resize it
    final img.Image resizedImage =
        img.copyResize(image, width: 224, height: 224);

    // Convert image to Float32List (this is required by the MobileNet model)
    List<double> imageAsList = [];

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = image.getPixel(x, y);
        final r = image.getRed(pixel) / 127.5 - 1.0;
        final g = img.getGreen(pixel) / 127.5 - 1.0;
        final b = img.getBlue(pixel) / 127.5 - 1.0;

        // Append normalized pixel data
        imageAsList.add(r);
        imageAsList.add(g);
        imageAsList.add(b);
      }
    }

    return Float32List.fromList(imageAsList).buffer.asUint8List();
  }

  // Run face recognition using MobileNet
  Future<List<double>> runFaceRecognition(File faceImage) async {
    // Preprocess the cropped face image
    Uint8List inputImage = preprocessImage(faceImage);

    // Get input and output shape
    var inputShape = interpreter.getInputTensor(0).shape;
    var outputShape = interpreter.getOutputTensor(0).shape;

    // Prepare input and output buffer
    var inputBuffer = inputImage.buffer.asFloat32List();
    var outputBuffer = Float32List(outputShape.reduce((a, b) => a * b));

    // Run the interpreter
    interpreter.run(inputBuffer, outputBuffer);

    // Extract embeddings as a list of floats (the face embedding)
    List<double> embeddings = outputBuffer.toList();
    print("Embeddings: $embeddings");

    return embeddings;
  }

  // Compare embeddings to recognize the face (calculate Euclidean distance)
  double calculateDistance(List<double> embeddings1, List<double> embeddings2) {
    double sum = 0.0;
    for (int i = 0; i < embeddings1.length; i++) {
      sum +=
          (embeddings1[i] - embeddings2[i]) * (embeddings1[i] - embeddings2[i]);
    }
    return sqrt(sum);
  }

  @override
  Widget build(BuildContext context) {
    //implement build
    throw UnimplementedError();
  }
}





**********************************************************************************************************************


Yes, you're correct. If you want to implement face recognition as part of the payment process, you would compare the user's live face (captured via camera) to the stored face (at facePath) before allowing them to proceed with a payment. This can serve as an additional security measure, ensuring that only the authorized user can complete the transaction.

Here’s how you can automate the face capture process and perform face recognition when a user interacts with the "Make Payment" button in Flutter:

Steps:
Open the Camera Automatically: Use the image_picker package to open the camera when the user clicks the payment button.
Capture the User’s Face: Once the image is captured, pass it through the face detection and recognition process.
Compare with Stored Face: Retrieve the stored face (e.g., from facePath), extract the embeddings, and compare them to the user's face captured during the payment attempt.
Here’s a sample approach to integrate the functionality:

1. Open Camera and Capture Face
You can use the image_picker to open the camera and capture the image when the user clicks the "Make Payment" button.

dart
Copy code
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> captureImageFromCamera() async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    return File(image.path);
  }
  return null;
}
2. Face Detection and Recognition Process
You will need to detect the face in the captured image, extract embeddings, and compare it with the stored face.

dart
Copy code
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;

Future<void> performFaceRecognition() async {
  // Step 1: Capture the user’s face from the camera
  File? capturedFace = await captureImageFromCamera();

  if (capturedFace != null) {
    // Step 2: Run face detection on the captured image (using the doFaceDetection method from earlier)
    await doFaceDetection(capturedFace);

    // Step 3: Get the stored face from local storage
    File storedFace = File('path_to_your_stored_face_image'); // Specify the correct path
    
    // Step 4: Perform face recognition by comparing the embeddings
    List<double> capturedFaceEmbeddings = await runFaceRecognition(capturedFace);
    List<double> storedFaceEmbeddings = await runFaceRecognition(storedFace);

    // Step 5: Compare embeddings
    double similarityScore = calculateDistance(capturedFaceEmbeddings, storedFaceEmbeddings);

    // Threshold for face recognition (this value can be adjusted)
    const double threshold = 1.0;
    if (similarityScore < threshold) {
      print('Face recognized successfully! Proceed with payment.');
    } else {
      print('Face not recognized. Payment denied.');
    }
  }
}
3. Trigger on Make Payment Button
When the user interacts with the "Make Payment" button, the face recognition process will be triggered:

dart
Copy code
ElevatedButton(
  onPressed: () async {
    await performFaceRecognition();
    // If face is recognized, proceed with the payment logic
  },
  child: Text("Make Payment"),
);
Explanation:
Step 1: Automatically opens the camera using image_picker when the user clicks the payment button.
Step 2: The captured face is processed by the doFaceDetection method to ensure there’s a face in the image.
Step 3: The embeddings (face data) are extracted from the captured face and compared to the previously stored face embeddings (at facePath).
Step 4: A similarity score is computed between the embeddings. If the score is below a certain threshold, the face is recognized and the payment proceeds.
Storage:
Stored face: You can save either the cropped face image itself or its embeddings (a compact numerical representation). Saving embeddings is more secure as they are not easily interpretable, and you only store the necessary data for comparison.
This flow can be integrated into your app’s payment logic to ensure face recognition occurs in the background while the user interacts with the payment button, improving both security and user experience.
*/


/* To implement the Google/Apple Pay button as a ListTile, you can replace the googleApplePayButton() function with an embedded button widget inside a ListTile. Additionally, you can make PaymentItem properties dynamic by fetching the values from user input or a database (like Firebase). Here’s how:
1.	Implement Google/Apple Pay as a ListTile:
o	Define googleApplePayButton as a widget that dynamically returns either a Google Pay or Apple Pay button based on the platform.
o	Embed it inside a ListTile.
2.	Make PaymentItem Properties Dynamic:
o	Use a TextEditingController to get user input for the label and amount.
o	Fetch dynamic values from Firebase (or any other database) and pass them to PaymentItem.
Here’s the code:
dart
Copy code
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../services/payment_configuration.dart';
import '../services/stripe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    _loadPaymentItems();
  }

  Future<void> _loadPaymentItems() async {
    // Fetch payment label and amount from Firestore
    DocumentSnapshot doc = await _firestore.collection('payments').doc('item1').get();
    if (doc.exists) {
      setState(() {
        _paymentItems = [
          PaymentItem(
            label: doc['label'],
            amount: doc['amount'],
            status: PaymentItemStatus.final_price,
          )
        ];
      });
    }
  }

  Widget googleApplePayTile() {
    final googlePayButton = GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePayConfig),
      paymentItems: _paymentItems,
      type: GooglePayButtonType.buy,
      onPaymentResult: onGooglePayResult,
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );

    final applePayButton = ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePayConfig),
      paymentItems: _paymentItems,
      style: ApplePayButtonStyle.black,
      onPaymentResult: onApplePayResult,
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );

    return ListTile(
      leading: Icon(Icons.payment, color: Colors.blue),
      title: Text(
        Platform.isIOS ? 'Apple Pay' : 'Google Pay',
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text('Secure Payment'),
      trailing: SizedBox(
        width: 120, // Width to contain the button
        child: Platform.isIOS ? applePayButton : googlePayButton,
      ),
      onTap: () {
        // Handle any additional on-tap functionality
      },
    );
  }

  void onGooglePayResult(paymentResult) {
    print("Google Pay Payment Result: $paymentResult");
  }

  void onApplePayResult(paymentResult) {
    print("Apple Pay Payment Result: $paymentResult");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _labelController,
                decoration: InputDecoration(labelText: 'Payment Label'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  // Update paymentItems with user input
                  setState(() {
                    _paymentItems = [
                      PaymentItem(
                        label: _labelController.text,
                        amount: _amountController.text,
                        status: PaymentItemStatus.final_price,
                      )
                    ];
                  });
                },
                child: Text('Update Payment Details'),
              ),
              SizedBox(height: 20),
              googleApplePayTile(),
            ],
          ),
        ),
      ),
    );
  }
}
Explanation
1.	Dynamic PaymentItem Creation:
o	Firebase: In _loadPaymentItems, data is fetched from Firebase Firestore (adjust the document structure based on your Firestore setup).
o	User Input: The text fields _labelController and _amountController let the user input custom values, which are then used to update _paymentItems.
2.	Google/Apple Pay Button in ListTile:
o	googleApplePayTile checks the platform and sets applePayButton or googlePayButton in the trailing property of ListTile.
Removing the "Add Payment Method" Button
Since Google Pay and Apple Pay automatically pull in saved payment methods, having an "Add Payment Method" button may not be necessary if using these exclusively. However, if you want users to have more options, such as linking a bank account, you could keep the button and integrate services like Plaid to allow users to connect additional payment methods.

*/
