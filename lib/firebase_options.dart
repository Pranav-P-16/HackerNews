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
    apiKey: 'AIzaSyCElMEpYO1m1J7If8b3KbhWc6hYAmbCH1U',
    appId: '1:965567493761:android:7e7dca9fed0e9f295abf80',
    messagingSenderId: '965567493761',
    projectId: 'swiggy-6de6a',
    storageBucket: 'swiggy-6de6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrazrTLTxugaAwC64FWEPFPkLPFUPRnV0',
    appId: '1:965567493761:ios:a299b94db48883405abf80',
    messagingSenderId: '965567493761',
    projectId: 'swiggy-6de6a',
    storageBucket: 'swiggy-6de6a.appspot.com',
    androidClientId: '965567493761-rjufci73kqqlcrt5ekcqlkggfh05em1h.apps.googleusercontent.com',
    iosClientId: '965567493761-bqvvqmsvvolmh3sqccoap64m76kt15hg.apps.googleusercontent.com',
    iosBundleId: 'com.lonewolfinteractive.hackernews.hackernews',
  );
}
