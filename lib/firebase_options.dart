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
    apiKey: 'AIzaSyDvCsxNHhid6bHVMNg7F1w3b8QL4hdIIFg',
    appId: '1:738082811071:web:bdc731e33512669a23ea0a',
    messagingSenderId: '738082811071',
    projectId: 'adkar-apk',
    authDomain: 'adkar-apk.firebaseapp.com',
    storageBucket: 'adkar-apk.appspot.com',
    measurementId: 'G-C1N078MRJD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgIHhT9JVaMW8dNuhrVB0V10E1FO2RmZo',
    appId: '1:738082811071:android:261e6c3c2312e0e123ea0a',
    messagingSenderId: '738082811071',
    projectId: 'adkar-apk',
    storageBucket: 'adkar-apk.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChHu0qlXSOPES4fKyHLraVExiQM7bn63Q',
    appId: '1:738082811071:ios:5e39e8021900e45223ea0a',
    messagingSenderId: '738082811071',
    projectId: 'adkar-apk',
    storageBucket: 'adkar-apk.appspot.com',
    iosBundleId: 'com.example.testapk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChHu0qlXSOPES4fKyHLraVExiQM7bn63Q',
    appId: '1:738082811071:ios:5e39e8021900e45223ea0a',
    messagingSenderId: '738082811071',
    projectId: 'adkar-apk',
    storageBucket: 'adkar-apk.appspot.com',
    iosBundleId: 'com.example.testapk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvCsxNHhid6bHVMNg7F1w3b8QL4hdIIFg',
    appId: '1:738082811071:web:95dbf424dd5754ea23ea0a',
    messagingSenderId: '738082811071',
    projectId: 'adkar-apk',
    authDomain: 'adkar-apk.firebaseapp.com',
    storageBucket: 'adkar-apk.appspot.com',
    measurementId: 'G-H5DM4NH846',
  );
}