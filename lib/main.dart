import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'screens/auth.dart';
import 'screens/splash.dart';
import 'screens/admin_screen.dart';
import 'screens/sub_admin_screen.dart';
import 'screens/student_screen.dart';
import 'screens/security_screen.dart';
import 'screens/firewall_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role Based Auth App',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }

                if (userSnapshot.hasData && userSnapshot.data != null) {
                  final userRole = userSnapshot.data!.get('role');
                  switch (userRole) {
                    case 'admin':
                      return const AdminScreen();
                    case 'sub-admin':
                      return const SubAdminScreen();
                    case 'security':
                      return const SecurityScreen();
                    case 'firewall':
                      return const FirewallScreen();
                    default: // student
                      return const StudentScreen();
                  }
                }

                // No user data found; go to auth screen
                return const AuthScreen();
              },
            );
          }

          // Not authenticated; show the Auth screen
          return const AuthScreen();
        },
      ),
    );
  }
}
