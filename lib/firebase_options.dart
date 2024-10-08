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
    apiKey: 'AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk',
    appId: '1:1090236390686:web:76c263e01b1b035889fd0f',
    messagingSenderId: '1090236390686',
    projectId: 'cryptobase-admin',
    authDomain: 'cryptobase-admin.firebaseapp.com',
    storageBucket: 'cryptobase-admin.appspot.com',
    measurementId: 'G-5RJESMY7JJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-l2fF9A0j6HqjCvqEL2iXjNPi3EUQqdo',
    appId: '1:1090236390686:android:d9bbe9668730a6f389fd0f',
    messagingSenderId: '1090236390686',
    projectId: 'cryptobase-admin',
    storageBucket: 'cryptobase-admin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWxe5xLaE8NPekDVtyQe_MJnHM38fejOE',
    appId: '1:1090236390686:ios:e767300c4689299f89fd0f',
    messagingSenderId: '1090236390686',
    projectId: 'cryptobase-admin',
    storageBucket: 'cryptobase-admin.appspot.com',
    iosBundleId: 'com.example.cryptobase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWxe5xLaE8NPekDVtyQe_MJnHM38fejOE',
    appId: '1:1090236390686:ios:e767300c4689299f89fd0f',
    messagingSenderId: '1090236390686',
    projectId: 'cryptobase-admin',
    storageBucket: 'cryptobase-admin.appspot.com',
    iosBundleId: 'com.example.cryptobase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk',
    appId: '1:1090236390686:web:15dbfdbf08271fd789fd0f',
    messagingSenderId: '1090236390686',
    projectId: 'cryptobase-admin',
    authDomain: 'cryptobase-admin.firebaseapp.com',
    storageBucket: 'cryptobase-admin.appspot.com',
    measurementId: 'G-1L4SHCBZJQ',
  );
}
