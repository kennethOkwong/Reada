import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/theme/theme.dart';
import 'package:reada/services/navigation service/app_router.dart';
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
          return MaterialApp.router(
            title: '${AppStrings.appName} ${config.name}',
            debugShowCheckedModeBanner: false,
            theme: ReadaTheme.lightTheme,
            darkTheme: ReadaTheme.darkTheme,
            themeMode: readaAppThemeNotifier.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
