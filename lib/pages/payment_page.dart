import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Wallet'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Uber Cash Section
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uber Cash',
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
              'Payment methods',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.money,
                color: Colors.green,
              ),
              title: Text(
                'Cash',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
              ),
              onTap: () {
                // Cash payment method tap
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add payment method functionality
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('+ Add payment method'),
            ),
            SizedBox(height: 24),

            // Ride Profiles Section
            Text(
              'Ride Profiles',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                'Personal',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Personal profile tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
                color: Colors.white54,
              ),
              title: Text(
                'Start using Uber for business',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              subtitle: Text(
                'Turn on business travel features',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
              onTap: () {
                // Uber for business tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
