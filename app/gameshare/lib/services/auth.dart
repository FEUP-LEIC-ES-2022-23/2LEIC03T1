import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Auth({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> _register(String email, String username) async {
    // TODO: Register user in database
  }

  Future<bool> signInEmailPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<bool> signUpEmailPassword(
    String email,
    String username,
    String password,
  ) async {
    try {
      await _register(email, username);
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
