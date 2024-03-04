import 'dart:convert';

import 'package:core/app/constants/app_assets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

final localNotification = FlutterLocalNotificationsPlugin();
const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
const iosInit = DarwinInitializationSettings();
const initSettings = InitializationSettings(
  android: androidInit,
  iOS: iosInit,
);

@lazySingleton
class NotificationService {
  late final FirebaseMessaging _firebaseMessaging;

  NotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  Future<void> initialize() async {
    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint('FCM token: $fcmToken');
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
  const androidDetails = AndroidNotificationDetails(
    "channelId",
    "notification",
    channelDescription: "Lumin Soft Maps",
    importance: Importance.max,
    priority: Priority.max,
    playSound: true,
    icon: AppAssets.clientAppImage,
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
