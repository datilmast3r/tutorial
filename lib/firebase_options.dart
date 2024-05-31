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
        return macos;
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
    apiKey: 'AIzaSyDPvmu9Fi0TTx9w0dij5WVOWRpvOa2aAys',
    appId: '1:439759902053:web:bd96851bcfea4c71acfd8c',
    messagingSenderId: '439759902053',
    projectId: 'volunteer-3d7d6',
    authDomain: 'volunteer-3d7d6.firebaseapp.com',
    storageBucket: 'volunteer-3d7d6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKxDNtzSg2biJvnAeJs4cQ7vKvYNmRcMk',
    appId: '1:439759902053:android:72fe6eeb3803cb4aacfd8c',
    messagingSenderId: '439759902053',
    projectId: 'volunteer-3d7d6',
    storageBucket: 'volunteer-3d7d6.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDPvmu9Fi0TTx9w0dij5WVOWRpvOa2aAys',
    appId: '1:439759902053:web:97cf90740e63f314acfd8c',
    messagingSenderId: '439759902053',
    projectId: 'volunteer-3d7d6',
    authDomain: 'volunteer-3d7d6.firebaseapp.com',
    storageBucket: 'volunteer-3d7d6.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEiKHgB-ZZTPdf56Vay_J4lRDVaLUlbv8',
    appId: '1:439759902053:ios:18e4bb8070a70842acfd8c',
    messagingSenderId: '439759902053',
    projectId: 'volunteer-3d7d6',
    storageBucket: 'volunteer-3d7d6.appspot.com',
    iosBundleId: 'com.example.tutorial',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEiKHgB-ZZTPdf56Vay_J4lRDVaLUlbv8',
    appId: '1:439759902053:ios:18e4bb8070a70842acfd8c',
    messagingSenderId: '439759902053',
    projectId: 'volunteer-3d7d6',
    storageBucket: 'volunteer-3d7d6.appspot.com',
    iosBundleId: 'com.example.tutorial',
  );

}