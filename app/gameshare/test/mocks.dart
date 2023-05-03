import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:gameshare/services/auth.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Auth {
  final MockFirebaseAuth auth;

  MockAuth({MockFirebaseAuth? auth}) : auth = auth ?? MockFirebaseAuth();

  @override
  Future<bool> signInEmailPassword(String email, String password) async {
    if (email == 'good_email' && password == 'good_pwd') return true;
    return false;
  }

  @override
  Future<bool> signUpEmailPassword(
      String email, String username, String password) async {
    if (email == 'good_email' &&
        username == 'good_username' &&
        password == 'good_pwd') return true;
    return false;
  }
}
