// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC2ioF6zQ6x_cF3R5CpXrr-j1vJP5Ky-sU',
    appId: '1:253924232353:web:2d67e18821acdbe83474e0',
    messagingSenderId: '253924232353',
    projectId: 'to-do-list-46eee',
    authDomain: 'to-do-list-46eee.firebaseapp.com',
    storageBucket: 'to-do-list-46eee.appspot.com',
    measurementId: 'G-5YRMDH7LR4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQw9PdKmdxJr2cIe5DIMpAaONvZb_KM3M',
    appId: '1:253924232353:android:03b85df9ae625cce3474e0',
    messagingSenderId: '253924232353',
    projectId: 'to-do-list-46eee',
    storageBucket: 'to-do-list-46eee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzPe_CE1QzvX9Kns0udOeq1GNzkLMmpOg',
    appId: '1:253924232353:ios:3ea482c0514981ab3474e0',
    messagingSenderId: '253924232353',
    projectId: 'to-do-list-46eee',
    storageBucket: 'to-do-list-46eee.appspot.com',
    iosBundleId: 'com.example.toDoListSmit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2ioF6zQ6x_cF3R5CpXrr-j1vJP5Ky-sU',
    appId: '1:253924232353:web:ec0c688f0cc0667d3474e0',
    messagingSenderId: '253924232353',
    projectId: 'to-do-list-46eee',
    authDomain: 'to-do-list-46eee.firebaseapp.com',
    storageBucket: 'to-do-list-46eee.appspot.com',
    measurementId: 'G-M59XLCW6YE',
  );
}