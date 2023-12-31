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
    apiKey: 'AIzaSyAfzC7HmCvZyand-90yJcgg-PnrZhEo67A',
    appId: '1:71605210815:web:a2919da8ba518a433bc00a',
    messagingSenderId: '71605210815',
    projectId: 'activities-amal',
    authDomain: 'activities-amal.firebaseapp.com',
    storageBucket: 'activities-amal.appspot.com',
    measurementId: 'G-49JY2N6LGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAx4Epl1xeoklUqZ54qa1SukONuOecaK4',
    appId: '1:71605210815:android:534f9a0ada94142b3bc00a',
    messagingSenderId: '71605210815',
    projectId: 'activities-amal',
    storageBucket: 'activities-amal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1jLT3ulTn-jdSg12aQsckidvQPC_9J7c',
    appId: '1:71605210815:ios:572bb83efd47c9ee3bc00a',
    messagingSenderId: '71605210815',
    projectId: 'activities-amal',
    storageBucket: 'activities-amal.appspot.com',
    iosBundleId: 'com.example.activityBeddiaf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1jLT3ulTn-jdSg12aQsckidvQPC_9J7c',
    appId: '1:71605210815:ios:22e5e69606b826623bc00a',
    messagingSenderId: '71605210815',
    projectId: 'activities-amal',
    storageBucket: 'activities-amal.appspot.com',
    iosBundleId: 'com.example.activityBeddiaf.RunnerTests',
  );
}
