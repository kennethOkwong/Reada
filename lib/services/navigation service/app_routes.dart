import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reada/features/authentication/presentation/verify%20code/enter_code_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/enter_email_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/reset_password_view.dart';
import 'package:reada/features/authentication/presentation/login%20screen/login_view.dart';
import 'package:reada/features/authentication/presentation/register%20screen/register_view.dart';
import 'package:reada/features/dashboard/presentation/dashboard_view.dart';

class AppRoutes {
  static const String main = '/';
  static const String startup = '/startup';
  static const String intro = '/intro';
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String enterEmail = '/enter-email';
  static const String enterCode = '/enter-code';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return CupertinoPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case AppRoutes.signUp:
        return CupertinoPageRoute(
          builder: (context) => const RegisterView(),
          settings: settings,
        );
      case AppRoutes.enterEmail:
        return CupertinoPageRoute(
          builder: (context) => const EnterEmailView(),
          settings: settings,
        );
      case AppRoutes.enterCode:
        return CupertinoPageRoute(
          builder: (context) => const EnterCodeView(),
          settings: settings,
        );
      case AppRoutes.resetPassword:
        return CupertinoPageRoute(
          builder: (context) => const ResetPasswordView(),
          settings: settings,
        );
      case AppRoutes.dashboard:
        return CupertinoPageRoute(
          builder: (context) => const DashboardView(),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Path not defined'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
