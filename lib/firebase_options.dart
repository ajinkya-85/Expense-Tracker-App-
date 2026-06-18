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
    apiKey: 'placeholder-web-api-key',
    appId: 'placeholder-web-app-id',
    messagingSenderId: 'placeholder-web-sender-id',
    projectId: 'placeholder-project-id',
    authDomain: 'placeholder-auth-domain.firebaseapp.com',
    storageBucket: 'placeholder-storage-bucket.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'placeholder-android-api-key',
    appId: 'placeholder-android-app-id',
    messagingSenderId: 'placeholder-android-sender-id',
    projectId: 'placeholder-project-id',
    storageBucket: 'placeholder-storage-bucket.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'placeholder-ios-api-key',
    appId: 'placeholder-ios-app-id',
    messagingSenderId: 'placeholder-ios-sender-id',
    projectId: 'placeholder-project-id',
    storageBucket: 'placeholder-storage-bucket.appspot.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'placeholder-macos-api-key',
    appId: 'placeholder-macos-app-id',
    messagingSenderId: 'placeholder-macos-sender-id',
    projectId: 'placeholder-project-id',
    storageBucket: 'placeholder-storage-bucket.appspot.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'placeholder-windows-api-key',
    appId: 'placeholder-windows-app-id',
    messagingSenderId: 'placeholder-windows-sender-id',
    projectId: 'placeholder-project-id',
    storageBucket: 'placeholder-storage-bucket.appspot.com',
  );
}
