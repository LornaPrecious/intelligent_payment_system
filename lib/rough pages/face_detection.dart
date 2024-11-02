/*
//FACE DETECTION USING GOOGLE_MLKIT
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

late ImagePicker picker =
      ImagePicker(); //variable picker of object imagepicker
  File? _image; //variable users can store their image 'file'

  late FaceDetector faceDetector; //declaring the face detector
  @override
  void initState() {
    //implement initState
    super.initState();
    //picker = ImagePicker();

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
*/