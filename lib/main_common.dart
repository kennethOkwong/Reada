import 'dart:async';

// import 'package:connect/servicees/payment/stripe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/theme/theme.dart';
import 'package:reada/features/onboarding/splash_view.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/services/navigation%20service/navigation_service.dart';
import 'package:toastification/toastification.dart';

Future<void> maincommon(AppFlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setUpLocator(config);

  runApp(MyApp(config: config));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.config});

  final AppFlavorConfig config;

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ListenableBuilder(
        listenable: readaAppThemeNotifier,
        builder: (context, child) {
          return MaterialApp(
            title: 'Reada ${config.name}',
            debugShowCheckedModeBanner: false,
            theme: ReadaTheme.lightTheme,
            darkTheme: ReadaTheme.darkTheme,
            themeMode: readaAppThemeNotifier.themeMode,
            home: SplashView(screenSize: MediaQuery.of(context).size),
            navigatorKey: locator<NavigationService>().navigatorKey,
            scaffoldMessengerKey:
                locator<NavigationService>().scaffoldMessengerKey,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
