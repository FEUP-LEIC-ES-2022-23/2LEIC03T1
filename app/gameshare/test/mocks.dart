import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:gameshare/services/auth.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Auth {
  final MockFirebaseAuth auth;

  MockAuth({MockFirebaseAuth? auth}) : auth = auth ?? MockFirebaseAuth();
  String get success => 'Succss';

  @override
  Future<String> signInEmailPassword(String email, String password) async {
    if (email == 'good_email' && password == 'good_pwd') return 'Success';
    return "Invalid email or password";
  }

  @override
  Future<String> signUpEmailPassword(
      String email, String username, String password) async {
    if (email == 'good_email' &&
        username == 'good_username' &&
        password == 'good_pwd') return 'Success';
    return "Email is not valid";
  }
}
