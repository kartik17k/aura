import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../page/QRpage.dart';
import '../page/registartion.dart';

class Event {
  final String name;
  final String description;
  final String time;
  final List<String> rules;
  final double fee; // Add registration fee property
  final List<String> subEvents; // Add sub-events

  Event({
    required this.name,
    required this.description,
    required this.time,
    required this.rules,
    required this.fee, // Include fee in constructor
    required this.subEvents, // Include sub-events in constructor
  });
}

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  // Navigate to the registration screen with event details, rules, fee, and sub-events
  void _navigateToRegistration(
      BuildContext context,
      String eventName,
      String eventDetails,
      List<String> eventRules,
      double eventFee,
      List<String> subEvents, // Add sub-events parameter
      ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(
          eventName: eventName,
          eventDetails: eventDetails,
          eventRules: eventRules,
          eventFee: eventFee,
          subEvents: subEvents, // Pass sub-events to RegistrationScreen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Event> events = [
      Event(
        name: 'Dancing Competition',
        description: 'Show off your dance moves in a thrilling competition.',
        time: '10:00 AM, 16th Oct',
        rules: [
          'Arrive 15 minutes early.',
          'Dress code: Casual dance attire.',
          'Max 3 minutes for performance.',
        ],
        fee: 1.0, // Registration fee
        subEvents: ['Solo Dance', 'Group Dance', 'Freestyle Dance'], // Add sub-events
      ),
      Event(
        name: 'Singing Contest',
        description: 'Sing your heart out and win exciting prizes!',
        time: '1:00 PM, 16th Oct',
        rules: [
          'Maximum song duration is 4 minutes.',
          'Accompanied by a background track only.',
          'No explicit lyrics allowed.',
        ],
        fee: 50.0, // Registration fee
        subEvents: ['Solo Singing', 'Duet Singing', 'Group Singing'], // Add sub-events
      ),
      Event(
        name: 'Drama Play',
        description: 'A captivating play performance by the drama club.',
        time: '3:00 PM, 17th Oct',
        rules: [
          'Maximum performance time: 20 minutes.',
          'Props should be arranged in advance.',
          'Participants must be dressed in costume before the event.',
        ],
        fee: 150.0, // Registration fee
        subEvents: ['Short Skits', 'Full Plays', 'Improv'], // Add sub-events
      ),
      Event(
        name: 'Art Exhibition',
        description: 'A showcase of the best artistic creations by students.',
        time: '10:00 AM, 18th Oct',
        rules: [
          'Art submissions should be handed in by 9:00 AM.',
          'No digital artworks allowed.',
          'Only one submission per student.',
        ],
        fee: 70.0, // Registration fee
        subEvents: ['Painting', 'Sketching', 'Sculpture'], // Add sub-events
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Dashboard',
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

      // Drawer added here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Student Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('View Events'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer

              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('QR'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QRPage(qrData: '')));
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _signOut(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome, Student!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(event.name),
                    subtitle: Text(
                      '${event.description}\nTime: ${event.time}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      _navigateToRegistration(
                        context,
                        event.name,
                        event.description,
                        event.rules,
                        event.fee, // Pass the fee to the registration screen
                        event.subEvents, // Pass sub-events to the registration screen
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
