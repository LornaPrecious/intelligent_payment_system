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

*/
