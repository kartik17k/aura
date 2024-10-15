import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  final String qrData;

  const QRPage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your QR Code',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Scan the QR code below:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Check if qrData is empty or null
              if (qrData.isNotEmpty) ...[
                // QR Code widget
                QrImageView(
                  data: qrData, // The data to be encoded into the QR code
                  version: QrVersions.auto,
                  size: 200.0, // Size of the QR code
                ),
                const SizedBox(height: 20),
                // Display the raw data under the QR code
                Text(
                  'Data: $qrData',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                // Message when QR code is not available
                const Text(
                  'Register for an event to get your QR code.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],

              const SizedBox(height: 30),

              // Back Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
