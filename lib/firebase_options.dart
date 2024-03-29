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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD9tCIFTti82tQbyiRxEi6GNzWvDDit7SE',
    appId: '1:228517866897:web:24de390365c294fbd4fe30',
    messagingSenderId: '228517866897',
    projectId: 'roti-7b4f8',
    authDomain: 'roti-7b4f8.firebaseapp.com',
    databaseURL: 'https://roti-7b4f8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'roti-7b4f8.appspot.com',
    measurementId: 'G-X97TYGZJLR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyF08IiOkr7j2Pi8bl8POhwlA8IWPNioU',
    appId: '1:228517866897:android:d2fec2f96d6990e0d4fe30',
    messagingSenderId: '228517866897',
    projectId: 'roti-7b4f8',
    databaseURL: 'https://roti-7b4f8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'roti-7b4f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSBr98qGkfE6lkU7MAdeQ5IYwSWanLeUU',
    appId: '1:228517866897:ios:a599233038765956d4fe30',
    messagingSenderId: '228517866897',
    projectId: 'roti-7b4f8',
    databaseURL: 'https://roti-7b4f8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'roti-7b4f8.appspot.com',
    iosBundleId: 'com.example.actlPrice',
  );
}
