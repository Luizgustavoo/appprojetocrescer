import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/class_notification.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notificationProvider.notifications.length,
        itemBuilder: (context, index) {
          final notification = notificationProvider.notifications[index];
          return ListTile(
            title: Text(notification.notification?.title ?? ''),
            subtitle: Text(notification.notification?.body ?? ''),
          );
        },
      ),
    );
  }
}
