import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:driver_app/firebase_options.dart';
import 'package:driver_map/di/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notifications/services/notification_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

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
              onGenerateRoute: onGenerateDriver,
              onGenerateTitle: (_) => context.getText('appName'),
              theme: driverAppTheme(),
            ),
          );
        },
      ),
    );
  }
}

Future<void> initializeDriverApp() async {
  await EasyLocalization.ensureInitialized();
  // The dependency injection in 'Core Package'
  await initializeDi();
  //  The dependency injection in 'Auth Package'
  await initAuthGetIt();
  //  The dependency injection in 'Driver Map Package'
  await initDriverMapsGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initialize(
    // ! topic: 'rideRequests',
    onNavigate: () {
      debugPrint('Navigation in the driver app happened');
      // Navigator.of(navigatorKey.currentContext!)
      //     .pushNamed(AppRoutes.historyRoute);
    },
  );
}

void preventLandScape() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}
