// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_6gCqsyr-7xfDfzOsoeIiKXM33v5HSC4',
    appId: '1:431010312457:web:3ad0ed74d736b87a7523d8',
    messagingSenderId: '431010312457',
    projectId: 'prototype-db-ccc10',
    authDomain: 'prototype-db-ccc10.firebaseapp.com',
    storageBucket: 'prototype-db-ccc10.appspot.com',
    measurementId: 'G-M5M8DT4GYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbuJ5ZGhTmDwxXSoCOwDeemt06wfOIknA',
    appId: '1:431010312457:android:6c1a11da56af52a97523d8',
    messagingSenderId: '431010312457',
    projectId: 'prototype-db-ccc10',
    storageBucket: 'prototype-db-ccc10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE0Wj6G8Yl-cYzWfKpqiVarM5fQ7ZWURg',
    appId: '1:431010312457:ios:a72f4a6cf7ef29db7523d8',
    messagingSenderId: '431010312457',
    projectId: 'prototype-db-ccc10',
    storageBucket: 'prototype-db-ccc10.appspot.com',
    iosClientId: '431010312457-ac43apjfsoo4ovbg6v5o7ea8tjjrqeha.apps.googleusercontent.com',
    iosBundleId: 'com.example.prototype',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDE0Wj6G8Yl-cYzWfKpqiVarM5fQ7ZWURg',
    appId: '1:431010312457:ios:a72f4a6cf7ef29db7523d8',
    messagingSenderId: '431010312457',
    projectId: 'prototype-db-ccc10',
    storageBucket: 'prototype-db-ccc10.appspot.com',
    iosClientId: '431010312457-ac43apjfsoo4ovbg6v5o7ea8tjjrqeha.apps.googleusercontent.com',
    iosBundleId: 'com.example.prototype',
  );
}