import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false; //varible to check if user is authenticated

  @override
  Widget build(BuildContext context) {
    // implement build

    return Scaffold(
      body: _buildUI(),

      floatingActionButton: _authButton(), //button to trigger authentication
    );
  }

  Widget _authButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (!_isAuthenticated) {
          final bool
              canAuthenticateWithBiometrics = // check if device supports biometric authentication
              await _auth.canCheckBiometrics;
          if (canAuthenticateWithBiometrics) {
            try {
              final bool didAuthenticate = await _auth.authenticate(
                  localizedReason:
                      'Please authenticate to show account balance', // authenticate user using biometric authentication
                  options: const AuthenticationOptions(
                    biometricOnly:
                        true, //locking how users authenticate themselves - only biometrics: If it's false users can use both biometrics and fingerprint
                  ));

              setState(() {
                _isAuthenticated =
                    didAuthenticate; //update the variable to check if user is authenticated
              });
            } catch (e) {
              //print(e);
            }
          }
        } else {
          setState(() {
            _isAuthenticated = false; //toggle the authentication state
          });
        }
      },
      child: Icon(!_isAuthenticated ? Icons.lock : Icons.lock_open),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ALIGNMENT
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Account Balance",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ), // Textstyle
          ),
          if (_isAuthenticated) //if _isAuthenticated == True
            const Text(
              "134000",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ), // Textstyle
            ),
          if (!_isAuthenticated)
            const Text(
              "***********",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ), // Textstyle
            )
        ],
      ),
    );
  }
}
