import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_payment_system/models/user.dart';
import 'package:intelligent_payment_system/pages/edit_profile.dart';
import 'package:intelligent_payment_system/services/auth_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    //Image.asset('/images/profile_icon.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _user!.username,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  // Text('Last visit: 04/08/2019'),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildProfileDetail('Country', _user!.fullname),
            _buildProfileDetail('Your Email', _user!.email),
            _buildProfileDetail('Your Phone', _user!.phonenumber),
            _buildProfileDetail('City, State', _user!.address),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[900],
                  minimumSize: Size(screenWidth - 30, 50)),
              child: const Text("Edit Profile"),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      _authService.signOut();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.w600),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Divider(),
        ],
      ),
    );
  }
}
