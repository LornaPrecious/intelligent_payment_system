import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import "package:intelligent_payment_system/services/auth_services.dart";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final currentUser = FirebaseAuth.instance.currentUser;
  final AuthService _authService = AuthService();
  UserModel? _user; //hold user data

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    // Replace with the UID of the logged-in user
    String uid = currentUser!.uid;

    UserModel? user = await _authService.getUserDetails(uid);
    if (user != null) {
      setState(() {
        _user = user; // Update _user with fetched data
      });
    } else {
      print("User data could not be retrieved.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save changes
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://example.com/profile.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          // Change profile picture
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildEditableField('Country', _user!.fullname),
              _buildEditableField('Your Email', _user!.email),
              _buildEditableField('Your Phone', _user!.phonenumber),
              _buildEditableField('City, State', _user!.address),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          TextFormField(
            initialValue: initialValue,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
