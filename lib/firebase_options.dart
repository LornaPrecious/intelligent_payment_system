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
    apiKey: 'AIzaSyCYTmP08AuaKLxZodEZp0nGWjpC8F1aQMw',
    appId: '1:1059943656554:web:d0bb77f358d7de0df6ae13',
    messagingSenderId: '1059943656554',
    projectId: 'intelligent-payment-system',
    authDomain: 'intelligent-payment-system.firebaseapp.com',
    storageBucket: 'intelligent-payment-system.appspot.com',
    measurementId: 'G-TRBQCTQSSL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABxTgttna_eSa0YYYDZMCpuHfUIeDeJgc',
    appId: '1:1059943656554:android:a4bd130e6b4b09ddf6ae13',
    messagingSenderId: '1059943656554',
    projectId: 'intelligent-payment-system',
    storageBucket: 'intelligent-payment-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj90PzqC4-G12-7iOW-R9s6SLKpGlGNA4',
    appId: '1:1059943656554:ios:3b9cd33c263c2080f6ae13',
    messagingSenderId: '1059943656554',
    projectId: 'intelligent-payment-system',
    storageBucket: 'intelligent-payment-system.appspot.com',
    iosBundleId: 'com.example.intelligentPaymentSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj90PzqC4-G12-7iOW-R9s6SLKpGlGNA4',
    appId: '1:1059943656554:ios:3b9cd33c263c2080f6ae13',
    messagingSenderId: '1059943656554',
    projectId: 'intelligent-payment-system',
    storageBucket: 'intelligent-payment-system.appspot.com',
    iosBundleId: 'com.example.intelligentPaymentSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYTmP08AuaKLxZodEZp0nGWjpC8F1aQMw',
    appId: '1:1059943656554:web:d0bb77f358d7de0df6ae13',
    messagingSenderId: '1059943656554',
    projectId: 'intelligent-payment-system',
    authDomain: 'intelligent-payment-system.firebaseapp.com',
    storageBucket: 'intelligent-payment-system.appspot.com',
    measurementId: 'G-TRBQCTQSSL',
  );
}
