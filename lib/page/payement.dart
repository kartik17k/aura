import 'package:chat_app/page/QRpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPage extends StatefulWidget {
  final String name;
  final int amount;

  const RazorPayPage({super.key, required this.name, required this.amount});

  @override
  _RazorPayPageState createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
  late Razorpay _razorpay;

  void openCheckout(int amount) async {
    var options = {
      'key': 'rzp_test_HQMIOIyah2OI07', // Replace with your RazorPay key
      'amount': amount * 100, // Razorpay accepts the amount in paise
      'name': widget.name,
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'}, // Prefill with contact and email
      'external': {
        'wallets': ['paytm'] // Allow Paytm wallet
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void handelPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Success: ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);

    // Navigate to QR page after successful payment
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QRPage(qrData: response.paymentId!), // Pass the payment ID to generate QR code
      ),
    );
  }

  void handelPaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed: ${response.message}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handelExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet: ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handelPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handelPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handelExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment details section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.blueAccent.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paying for:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Amount:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${widget.amount}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Payment button section
            Center(
              child: ElevatedButton(
                onPressed: () {
                  openCheckout(widget.amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  "Make Payment",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Instructions or message section
            Center(
              child: Text(
                "You will be redirected to RazorPay for secure payment.",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
