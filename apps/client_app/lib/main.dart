import 'package:bloc/bloc.dart';
import 'package:core/presentation/cubit/app_bloc_observer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lumin_soft_maps/client_app.dart';
import 'package:notifications/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClientApp();
  // ! await FirebaseApi().initNotifications();
  await NotificationService().initialize();
  preventLandScape();
  Bloc.observer = MyAppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const ClientApp(),
    ),
  );
}
