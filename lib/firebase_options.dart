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
    apiKey: 'AIzaSyBEBR9L2OErZxwdrMnGzA1Xc3k2lu6gJPU',
    appId: '1:477738685701:web:f8606001399576bb67136c',
    messagingSenderId: '477738685701',
    projectId: 'posts-f8566',
    authDomain: 'posts-f8566.firebaseapp.com',
    storageBucket: 'posts-f8566.appspot.com',
    measurementId: 'G-VXFK4JN1TG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjfUueOfPQVs7VEhMl-UD7MZDayacTqkE',
    appId: '1:477738685701:android:7865044e3da9a40b67136c',
    messagingSenderId: '477738685701',
    projectId: 'posts-f8566',
    storageBucket: 'posts-f8566.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNEwDcDN4AWlSzAqASGxNVEt_POhlvbhI',
    appId: '1:477738685701:ios:801bd2facfb2d8eb67136c',
    messagingSenderId: '477738685701',
    projectId: 'posts-f8566',
    storageBucket: 'posts-f8566.appspot.com',
    iosBundleId: 'com.example.posts',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNEwDcDN4AWlSzAqASGxNVEt_POhlvbhI',
    appId: '1:477738685701:ios:2a03ce4a82a52b5167136c',
    messagingSenderId: '477738685701',
    projectId: 'posts-f8566',
    storageBucket: 'posts-f8566.appspot.com',
    iosBundleId: 'com.example.posts.RunnerTests',
  );
}
