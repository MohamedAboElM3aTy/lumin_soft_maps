import 'package:auth/presentation/screens/auth_screen.dart';
import 'package:core/app/services/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/screens/home_screen.dart';
import 'package:map/presentation/screens/map_screen.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case AppRoutes.authRoute:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case AppRoutes.mapRoute:
      return MaterialPageRoute(
        builder: (_) => const MapScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
  }
}
