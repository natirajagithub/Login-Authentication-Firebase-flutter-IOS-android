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
    apiKey: 'AIzaSyDdiIR931qWDJN0YRmxr1zlGJVsPN33_HE',
    appId: '1:595847887212:web:e81ab7b9503cc2400ddb49',
    messagingSenderId: '595847887212',
    projectId: 'loginpage-a1799',
    authDomain: 'loginpage-a1799.firebaseapp.com',
    storageBucket: 'loginpage-a1799.appspot.com',
    measurementId: 'G-LLK1YB1DD9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXVcCW909PQdz-X0eXFg7apz7UMMLtuAs',
    appId: '1:595847887212:android:971040bf7755f16c0ddb49',
    messagingSenderId: '595847887212',
    projectId: 'loginpage-a1799',
    storageBucket: 'loginpage-a1799.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCL1Vz5-mpWAoEctAp_j5rhMoKu6p2hxd4',
    appId: '1:595847887212:ios:277a45711c567c990ddb49',
    messagingSenderId: '595847887212',
    projectId: 'loginpage-a1799',
    storageBucket: 'loginpage-a1799.appspot.com',
    androidClientId: '595847887212-5k1eqc8p8174hntpdub332urptdaocug.apps.googleusercontent.com',
    iosClientId: '595847887212-jf2kdvjd5bl6vveqgqeb30td118vsval.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCL1Vz5-mpWAoEctAp_j5rhMoKu6p2hxd4',
    appId: '1:595847887212:ios:277a45711c567c990ddb49',
    messagingSenderId: '595847887212',
    projectId: 'loginpage-a1799',
    storageBucket: 'loginpage-a1799.appspot.com',
    androidClientId: '595847887212-5k1eqc8p8174hntpdub332urptdaocug.apps.googleusercontent.com',
    iosClientId: '595847887212-jf2kdvjd5bl6vveqgqeb30td118vsval.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdiIR931qWDJN0YRmxr1zlGJVsPN33_HE',
    appId: '1:595847887212:web:20e18569a735fb3a0ddb49',
    messagingSenderId: '595847887212',
    projectId: 'loginpage-a1799',
    authDomain: 'loginpage-a1799.firebaseapp.com',
    storageBucket: 'loginpage-a1799.appspot.com',
    measurementId: 'G-SMVWMXHZ1M',
  );
}
