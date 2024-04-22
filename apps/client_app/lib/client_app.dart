import 'package:auth/auth.dart';
import 'package:chat/di/injection_container.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumin_soft_maps/firebase_options.dart';
import 'package:map/map.dart';
import 'package:notifications/services/notification_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class ClientApp extends StatelessWidget {
  const ClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocaleCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          final localeCubit = context.read<LocaleCubit>();
          return ScreenUtilInit(
            // The size of the smallest iphone ie iPhone 6's
            designSize: const Size(375, 667),
            // Adapt the text according to min width & Height
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              locale: context.locale,
              supportedLocales: localeCubit.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: onGenerateClient,
              onGenerateTitle: (_) => context.getText('appName'),
              theme: clientAppTheme(),
            ),
          );
        },
      ),
    );
  }
}

Future<void> initializeClientApp() async {
  await EasyLocalization.ensureInitialized();
  // The dependency injection in 'Core Package'
  await initializeDi();
  //  The dependency injection in 'Auth Package'
  await initAuthGetIt();
  //  The dependency injection in 'Map Package'
  await initMapsGetIt();
  // The dependency injection in 'Chat Package'
  await initChatGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initialize(
    // ! topic: 'rideResponses',
    onNavigate: () {
      debugPrint('Navigation in the client app happened');
      // Navigator.of(navigatorKey.currentContext!)
      //     .pushNamed(AppRoutes.historyRoute);
    },
  );
}

void preventLandScape() => SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
