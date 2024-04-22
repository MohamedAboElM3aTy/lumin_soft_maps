import 'package:bloc/bloc.dart';
import 'package:core/presentation/cubit/app_bloc_observer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'driver_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDriverApp();
  // ! await FirebaseApi().initNotifications();
  // ? await NotificationService().initialize();
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
      child: const DriverApp(),
    ),
  );
}
