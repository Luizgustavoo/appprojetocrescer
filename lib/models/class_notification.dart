import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<RemoteMessage> _notifications = [];

  List<RemoteMessage> get notifications => _notifications;

  void addNotification(RemoteMessage notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
