import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.fuchsia:
        break;
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
    throw UnsupportedError(
        'DefaultFirebaseOptions não é compatível com esta plataforma.');
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAActoovUuK9cVEjWb0VbSaaKaSGZRgKTA',
    appId: '1:869247178721:android:7ee5bae244b8d41f6564a0',
    messagingSenderId: '869247178721',
    projectId: 'projeto-crescer-8fef9',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCujJkF3eVOSKVWzdlXiWZ43xybJ-9TWVs',
    appId: '1:869247178721:ios:a503d05d91866df76564a0',
    messagingSenderId: '869247178721',
    projectId: 'projeto-crescer-8fef9',
    androidClientId:
        '869247178721-2747svvbb8rnco15vt53anj94obop5hv.apps.googleusercontent.com',
    iosClientId:
        '869247178721-oa6vq2o60ea1bgv9bn4nv1rvqnr4b0l2.apps.googleusercontent.com',
    // iosBundleId: 'xxxxxxxxxxxxxxxxxxx',
  );
}
