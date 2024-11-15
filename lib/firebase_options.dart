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
    apiKey: 'AIzaSyCxQGPXFvWQDmJIZkACzatUbOhkI0ivses',
    appId: '1:809372470283:web:f10f1d2b3884a7dd610b0e',
    messagingSenderId: '809372470283',
    projectId: 'synergee-1255f',
    authDomain: 'synergee-1255f.firebaseapp.com',
    storageBucket: 'synergee-1255f.firebasestorage.app',
    measurementId: 'G-CNBWJ93TLG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg-2iadcQRjdNH1YFr1JZeVxqRPlpv7yI',
    appId: '1:809372470283:android:87e7c4754eb750b8610b0e',
    messagingSenderId: '809372470283',
    projectId: 'synergee-1255f',
    storageBucket: 'synergee-1255f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAARlRWnCU-9fEfIwN1u6-oLuuw3aLVONg',
    appId: '1:809372470283:ios:e2f75a53caca9fde610b0e',
    messagingSenderId: '809372470283',
    projectId: 'synergee-1255f',
    storageBucket: 'synergee-1255f.firebasestorage.app',
    androidClientId: '809372470283-gg75nr0vc1val9c01tut34ignbimqbal.apps.googleusercontent.com',
    iosClientId: '809372470283-37itbarq17vk7p2cuo7fs1eo8sdvqops.apps.googleusercontent.com',
    iosBundleId: 'com.example.synergee',
  );
}