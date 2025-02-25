import 'package:flutter/material.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/enter_code_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/enter_email_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/reset_password_view.dart';
import 'package:reada/features/authentication/presentation/login%20screen/login_view.dart';
import 'package:reada/features/authentication/presentation/register%20screen/register_view.dart';

class AppRoutes {
  static const String main = '/';
  static const String startup = '/startup';
  static const String intro = '/intro';
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String enterEmail = '/enter-email';
  static const String enterCode = '/enter-code';
  static const String resetPassword = '/reset-password';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
          settings: settings,
        );
      case AppRoutes.enterEmail:
        return MaterialPageRoute(
          builder: (context) => const EnterEmailView(),
          settings: settings,
        );
      case AppRoutes.enterCode:
        return MaterialPageRoute(
          builder: (context) => const EnterCodeView(),
          settings: settings,
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
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
