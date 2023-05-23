import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_actions.dart';

class Auth {
  Auth({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final String _success = 'Success';

  User? get user => _auth.currentUser;
  String get success => _success;
  String? get email => _auth.currentUser?.email;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String translateFirebaseError(String error) {
    if (error.contains('user-not-found')) {
      return 'User not found';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password';
    } else if (error.contains('email-already-in-use')) {
      return 'Email is already in use';
    } else if (error.contains('invalid-email')) {
      return 'Email is not valid';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak';
    } else if (error.contains('empty')) {
      return 'Fields cannot be empty';
    } else {
      return error;
    }
  }

  Future<void> _register(String email, String username) async {
    await addUser(username, email);
  }

  Future<String> signInEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _success;
    } catch (e) {
      return translateFirebaseError(e.toString());
    }
  }

  Future<String> signUpEmailPassword(
      String email, String username, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _register(email, username);
      return _success;
    } catch (e) {
      return translateFirebaseError(e.toString());
    }
  }

  Future<String> sendPasswordRecoveryEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return _success;
    } catch (e) {
      return translateFirebaseError(e.toString());
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('rememberMe');
    prefs.remove('isDarkMode');
    return _auth.signOut();
  }
}
