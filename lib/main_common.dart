import 'dart:async';

// import 'package:connect/servicees/payment/stripe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/theme/light_theme.dart';
import 'package:reada/features/authentication/presentation/landing_view/landing_view.dart';
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
      child: MaterialApp(
        title: 'Reada ${config.name}',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        themeMode: ThemeMode.light,
        home: const LandingView(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        scaffoldMessengerKey: locator<NavigationService>().scaffoldMessengerKey,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
