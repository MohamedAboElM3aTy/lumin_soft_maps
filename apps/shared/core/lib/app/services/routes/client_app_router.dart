import 'package:auth/presentation/screens/auth_screen.dart';
import 'package:chat/presentation/screens/chat_screen.dart';
import 'package:core/app/constants/app_assets.dart';
import 'package:core/app/services/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/screens/home_screen.dart';
import 'package:map/presentation/screens/client_map_screen.dart';
import 'package:map/presentation/screens/search_screen.dart';

Route<dynamic> onGenerateClient(
  RouteSettings settings,
) {
  switch (settings.name) {
    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(
          title: 'Client',
          imageName: AppAssets.clientAppImage,
        ),
      );
    case AppRoutes.authRoute:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(isClient: true),
      );
    case AppRoutes.mapClientRoute:
      return MaterialPageRoute(
        builder: (_) => const ClientMapScreen(),
      );
    case AppRoutes.searchRoute:
      return MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      );
    case AppRoutes.chatRoute:
      return MaterialPageRoute(
        builder: (_) => const ChatScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(
          title: 'Client',
          imageName: AppAssets.clientAppImage,
        ),
      );
  }
}
