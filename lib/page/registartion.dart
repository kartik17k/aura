import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/page/payement.dart'; // Path to your RazorPay page

class RegistrationScreen extends StatefulWidget {
  final String eventName;
  final String eventDetails;
  final List<String> eventRules;
  final double eventFee;
  final List<String> subEvents; // Add subEvents as a parameter

  const RegistrationScreen({
    Key? key,
    required this.eventName,
    required this.eventDetails,
    required this.eventRules,
    required this.eventFee,
    required this.subEvents, // Initialize subEvents in the constructor
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedSubEvent; // Variable to store the selected sub-event

  @override
  void initState() {
    super.initState();
    _setUserEmail(); // Get the current user's email
  }

  // Get the logged-in user's email and set it in the emailController
  void _setUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      _emailController.text = user.email!;
    }
  }

  // Method to show confirmation dialog
  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to register for ${widget.eventName}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registered successfully!')),
                );

                // Navigate to the payment page with the required details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RazorPayPage(
                      name: _nameController.text, // Pass user name
                      amount: widget.eventFee.toInt(), // Convert fee to integer for RazorPay
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register for ${widget.eventName}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Custom color for the AppBar
      ),
      body: SingleChildScrollView( // Allows scrolling if the keyboard appears
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event: ${widget.eventName}',
                  style: const TextStyle(
                    fontSize: 28, // Increased font size for the event name
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Custom color for the event name
                  ),
                ),
                const SizedBox(height: 16),

                // Display event details
                Text(
                  widget.eventDetails,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]), // Subtle color for details
                ),
                const SizedBox(height: 16),

                // Display event rules
                const Text(
                  'Event Rules:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                for (var rule in widget.eventRules)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Colors.blue)), // Color for bullet
                        Expanded(child: Text(rule, style: TextStyle(color: Colors.grey[700]))), // Color for rule text
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                // Display registration fee
                Text(
                  'Registration Fee: \₹${widget.eventFee.toStringAsFixed(2)}', // Show fee in a formatted way
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Highlight fee in red
                  ),
                ),
                const SizedBox(height: 16),

                // Dropdown for sub-events
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Sub-Event',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue), // Border color
                    ),
                  ),
                  value: _selectedSubEvent,
                  items: widget.subEvents.map((subEvent) {
                    return DropdownMenuItem<String>(
                      value: subEvent,
                      child: Text(subEvent, style: TextStyle(fontWeight: FontWeight.normal)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSubEvent = newValue; // Update the selected sub-event
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a sub-event';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Registration form fields
                const Text(
                  'Fill in your details below to register:',
                  style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold), // Custom color for instructions
                ),
                const SizedBox(height: 16),

                // Name TextFormField
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue), // Color for border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Focused border color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email TextFormField
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue), // Color for border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Focused border color
                    ),
                  ),
                  readOnly: true, // Make the email field read-only since it comes from Firebase
                ),
                const SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners for the button
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Show confirmation dialog before registration
                      _showConfirmationDialog(context);
                    }
                  },
                  child: const Text('Register', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
