import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('Autorizado');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('revogado0');
      } else {
        AppSettings.openNotificationSettings();
      }
    }
  }
}
