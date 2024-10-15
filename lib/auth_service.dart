import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up a user
  Future<User?> signUp(String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // Add the user to Firestore with their role
      await _firestore.collection('users').doc(user?.uid).set({
        'email': email,
        'role': role,
      });

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign in a user
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
