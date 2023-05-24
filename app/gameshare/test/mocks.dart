import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:gameshare/services/auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:file/file.dart';

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

class MockCacheManager extends Mock implements BaseCacheManager {
  static const fileSystem = LocalFileSystem();
  @override
  Stream<FileResponse> getFileStream(
      String url, {
        String? key,
        Map<String, String>? headers,
        bool? withProgress,
      }) async* {

    final file = fileSystem.file('mock_image.jpg');

    yield FileInfo(
      file, // Path to the asset
      FileSource.Cache, // Simulate a cache hit
      DateTime(2050), // Very long validity
      url, // Source url
    );
  }
}
