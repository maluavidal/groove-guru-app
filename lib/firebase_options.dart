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
    apiKey: 'AIzaSyC39KHWMC1tOjWTYGti8a_VLh49eht5ZNM',
    appId: '1:874029086467:web:f5eb205a9b43f12491db36',
    messagingSenderId: '874029086467',
    projectId: 'groove-guru',
    authDomain: 'groove-guru.firebaseapp.com',
    storageBucket: 'groove-guru.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBb44wcgpzejj5m19LiKYdQYGVR2JJdQcA',
    appId: '1:874029086467:android:86369d91ca03714391db36',
    messagingSenderId: '874029086467',
    projectId: 'groove-guru',
    storageBucket: 'groove-guru.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1a9OIQNtHM_5c8OD7PymIBKq6lWpjRXE',
    appId: '1:874029086467:ios:1be00e6c75c5460391db36',
    messagingSenderId: '874029086467',
    projectId: 'groove-guru',
    storageBucket: 'groove-guru.appspot.com',
    iosBundleId: 'com.example.grooveGuruApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1a9OIQNtHM_5c8OD7PymIBKq6lWpjRXE',
    appId: '1:874029086467:ios:28cb63544959d71191db36',
    messagingSenderId: '874029086467',
    projectId: 'groove-guru',
    storageBucket: 'groove-guru.appspot.com',
    iosBundleId: 'com.example.grooveGuruApp.RunnerTests',
  );
}
