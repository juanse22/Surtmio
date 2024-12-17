import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithPhone(String phoneNumber, String password) async {
    // Implementa el registro aquí.
  }

  Future<void> signInWithPhone(String phoneNumber, String password) async {
    // Implementa el inicio de sesión aquí.
  }
}
