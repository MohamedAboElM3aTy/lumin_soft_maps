import 'dart:convert';

import 'package:core/app/constants/app_constants.dart';
import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Lumin Soft',
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    AppConstants.fcmToken = await _firebaseMessaging.getToken();
    debugPrint('fcmToken: ${AppConstants.fcmToken}');
    initPushNotification();
    initLocalNotification();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('title: ${message.notification?.title}');
    debugPrint('body: ${message.notification?.body}');
    debugPrint('data: ${message.data}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    if (message.data.containsKey('topic') &&
        message.data['topic'] == 'location') {
      debugPrint('Location notification received!');
      debugPrint('title: ${message.notification?.title}');
      debugPrint('body: ${message.notification?.body}');
      debugPrint('data: ${message.data}');
      Fluttertoast.showToast(
        msg: '${message.data}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // onNavigate(message.data['target_page'] ?? '');
    }
  }

  Future initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.subscribeToTopic('location');
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification != null) {
        await _localNotifications.show(
          message.notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              priority: Priority.max,
              playSound: true,
              icon: 'assets/images/new_logo.jpg',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future initLocalNotification() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) async {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }
}
