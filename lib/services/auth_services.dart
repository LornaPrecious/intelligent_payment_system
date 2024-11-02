import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<User?> registerWithEmailAndPassword(String username, String fullname,
      String email, String phonenumber, String address, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Create a new user in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "username": username,
          "fullname": fullname,
          "email": email,
          "phonenumber": phonenumber,
          "address": address,
        });
      }

      await user?.sendEmailVerification();
      return user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Anonymous accounts are not enabled";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your email is invalid";
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }

      return Future.error(errorMessage);
    }
  }

  // Sign in an existing user
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "account-exists-with-different-credential":
          errorMessage = "Account exists with different credentials";
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }
      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      ); */
      return Future.error(errorMessage);
    }
  }

  //SIGN OUT

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //GOOGLE SIGN IN
  signInWithGoogle() async {
    //interactive sign in process

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //user cancels google sign in pop up screen

    if (googleUser == null) return;
    // Obtain the auth details from the request

    final GoogleSignInAuthentication gAuth = await googleUser.authentication;
    // Create a new credential for user

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sign in
    return await _auth.signInWithCredential(credential);
  }

  // Retrieve user details from Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  // Retrieve user details
  Future<UserModel?> getUserDetails(String uid) async {
    return await getUser(uid);
  }
}
