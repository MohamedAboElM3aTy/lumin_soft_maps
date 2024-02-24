import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumin_soft_maps/firebase_options.dart';
import 'package:map/map.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              locale: context.locale,
              supportedLocales: localeCubit.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: onGenerate,
              onGenerateTitle: (_) => context.getText('appName'),
              theme: appTheme(),
            ),
          );
        },
      ),
    );
  }
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  // The dependency injection in 'Core Package'
  await initializeDi();
  //  The dependency injection in 'Auth Package'
  await init();
  //  The dependency injection in 'Map Package'
  await initMapsGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void preventLandScape() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}
