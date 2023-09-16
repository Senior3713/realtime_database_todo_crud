import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

sealed class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<bool> signUp(String username, String email, String password, String confirmPassword) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null) {
        credential.user!.updateDisplayName(username);
      }

      return credential.user != null;
    } catch(e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null;
    } catch(e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch(e) {
      debugPrint("Error: $e");
      return false;
    }
  }
}