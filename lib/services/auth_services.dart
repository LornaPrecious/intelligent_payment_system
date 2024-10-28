import 'package:firebase_auth/firebase_auth.dart';
import '../services/registration_service.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // Register a new user
  Future<User?> registerWithEmailAndPassword(String username, String fullname,
      String email, String phonenumber, String address, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Create a new user in Firestore
      if (user != null) {
        UserModel newUser = UserModel(
            uid: user.uid,
            username: username,
            fullname: fullname,
            email: email,
            phonenumber: phonenumber,
            address: address);
        await _userService.createUser(newUser);
      }

      return user;
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  // Sign in an existing user
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Retrieve user details
  Future<UserModel?> getUserDetails(String uid) async {
    return await _userService.getUser(uid);
  }
}
