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
    apiKey: 'AIzaSyCfFc-wycoPvkb1FHCDj8XNJN6l1tGW1_s',
    appId: '1:546575061696:web:3dfe6d25593cba3a811325',
    messagingSenderId: '546575061696',
    projectId: 'realtime-database-todo',
    authDomain: 'realtime-database-todo.firebaseapp.com',
    storageBucket: 'realtime-database-todo.appspot.com',
    measurementId: 'G-0H9KP2SJJD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEDdKxbclkfEQPsg1IRF6ikCwWVyJUIXg',
    appId: '1:546575061696:android:dc296101fca00250811325',
    messagingSenderId: '546575061696',
    projectId: 'realtime-database-todo',
    storageBucket: 'realtime-database-todo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpvNZRulX5MrWVwfzwbSjEIGHmym6V1vg',
    appId: '1:546575061696:ios:257584889c008485811325',
    messagingSenderId: '546575061696',
    projectId: 'realtime-database-todo',
    storageBucket: 'realtime-database-todo.appspot.com',
    iosBundleId: 'com.jurakuziyev.realtimeDatabaseTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpvNZRulX5MrWVwfzwbSjEIGHmym6V1vg',
    appId: '1:546575061696:ios:b42bf14fff213b61811325',
    messagingSenderId: '546575061696',
    projectId: 'realtime-database-todo',
    storageBucket: 'realtime-database-todo.appspot.com',
    iosBundleId: 'com.jurakuziyev.realtimeDatabaseTodo.RunnerTests',
  );
}
