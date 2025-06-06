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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArBjUfyepJ-bJ3WEYIuLn-vlT2mHaEPCE',
    appId: '1:540715503441:android:821df5cd55df91f5300d70',
    messagingSenderId: '540715503441',
    projectId: 'flutter-prep-d8772',
    databaseURL: 'https://flutter-prep-d8772-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-d8772.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnfm2mY_rPXNbcV_PEKesFNr3iMZg_rxE',
    appId: '1:540715503441:ios:c21748139fd0e16b300d70',
    messagingSenderId: '540715503441',
    projectId: 'flutter-prep-d8772',
    databaseURL: 'https://flutter-prep-d8772-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-d8772.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

}