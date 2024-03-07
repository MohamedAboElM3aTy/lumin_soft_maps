import 'package:auth/presentation/screens/auth_screen.dart';
import 'package:core/app/constants/app_assets.dart';
import 'package:core/app/services/routes/app_routes.dart';
import 'package:driver_map/driver_map.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/screens/home_screen.dart';

Route<dynamic> onGenerateDriver(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(
          title: 'Driver',
          imageName: AppAssets.driverAppImage,
        ),
      );
    case AppRoutes.authRoute:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(isClientApp: false),
      );
    case AppRoutes.mapDriverRoute:
      return MaterialPageRoute(
        builder: (_) => const DriverMapScreen(),
      );
    case AppRoutes.historyRoute:
      return MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(
          title: 'Driver',
          imageName: AppAssets.driverAppImage,
        ),
      );
  }
}
