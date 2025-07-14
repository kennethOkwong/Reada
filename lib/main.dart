import 'package:flutter/material.dart';
import 'package:reada/app%20core/locator.dart';
import 'package:reada/app%20core/theme/light_theme.dart';
import 'package:reada/features/authentication/presentation/landing%20screen/landing_view.dart';
import 'package:reada/services/navigation%20service/navigation_service.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Reada',
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
