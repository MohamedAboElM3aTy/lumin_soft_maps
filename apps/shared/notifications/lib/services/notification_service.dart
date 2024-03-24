import 'dart:convert';

import 'package:core/app/constants/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final localNotification = FlutterLocalNotificationsPlugin();
const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
const iosInit = DarwinInitializationSettings();
const initSettings = InitializationSettings(
  android: androidInit,
  iOS: iosInit,
);

class NotificationService {
  late final FirebaseMessaging _firebaseMessaging;

  NotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  Future<void> initialize() async {
    AppConstants.fcmToken = await _firebaseMessaging.getToken();
    debugPrint('FCM token: ${AppConstants.fcmToken}');
    await localNotification.initialize(initSettings);
    localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        await _showNotification(message);
        debugPrint('onMessage: ${message.data}');
      },
    );
  }
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await _showNotification(message);
  debugPrint("On background message: ${message.data.toString()}");
}

Future<void> _showNotification(RemoteMessage message) async {
  await FirebaseMessaging.instance.subscribeToTopic('location');
  const androidDetails = AndroidNotificationDetails(
    "channelId",
    "notification",
    channelDescription: "Lumin Soft",
    importance: Importance.max,
    priority: Priority.max,
    playSound: true,
    icon: "assets/images/new_logo.jpg",
  );
  const iosDetails = DarwinNotificationDetails();
  const generalNotificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );
  final String id = message.data['notification_id'] ?? '';
  await localNotification.show(
    int.tryParse(id) ?? 0,
    message.data['title'] ?? message.notification?.title,
    message.data['text'] ?? message.notification?.body,
    generalNotificationDetails,
    payload: json.encode(message.data),
  );
}
