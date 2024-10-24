import 'package:flutter/material.dart';
import 'package:intelligent_payment_system/models/user.dart';
import '../services/stripe_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, this.user});

  final User? user;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
/*
Baby blue: Color.fromARGB(1, 212, 241, 244)
Blue green: Color.fromARGB(1,117,230,218)
Blue Grotto: Color.fromARGB(1,24,154,180)
Navy Blue: Color.fromARGB(1,5,68,94)

*/

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App's Cash Section
              Card(
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cash',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ksh 0.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Add funds functionality
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Add Funds'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Payment Methods Section
              Text(
                'Make payment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.money,
                  color: Colors.blue,
                ),
                title: Text(
                  'Pay with card',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  // Cash payment method tap
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  StripeService.instance.makePayment();
                  // Make payment functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('+ Add payment method'),
              ),
              SizedBox(height: 24),

              // Ride Profiles Section
              Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                title: Text(
                  'Personal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Personal profile tap
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.business,
                  color: Colors.grey,
                ),
                title: Text(
                  'Purchase History',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Previous payments',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  // History purchases
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
