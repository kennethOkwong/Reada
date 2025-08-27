import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_view.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/enter_email_view.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/reset_password_view.dart';
import 'package:reada/features/authentication/presentation/login_view/login_view.dart';
import 'package:reada/features/authentication/presentation/register_view/register_view.dart';
import 'package:reada/features/dashboard/presentation/dashboard_view.dart';
import 'package:reada/features/onboarding/landing_view/landing_view.dart';

class AppRoutes {
  static const String main = '/';
  static const String startup = '/startup';
  static const String intro = '/intro';
  static const String signUp = '/signup';
  static const String businessProfile = '/business-profile';
  static const String login = '/login';
  static const String enterEmail = '/enter-email';
  static const String enterCode = '/enter-code';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.intro:
        return CupertinoPageRoute(
          builder: (context) => const LandingView(),
          settings: settings,
        );
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
          builder: (context) => EnterEmailView(),
          settings: settings,
        );
      case AppRoutes.enterCode:
        return CupertinoPageRoute(
          builder: (context) => EnterCodeView(
            codeModel: settings.arguments as SendCodeRequestDto,
          ),
          settings: settings,
        );
      case AppRoutes.resetPassword:
        return CupertinoPageRoute(
          builder: (context) => ResetPasswordView(
            email: settings.arguments as String,
          ),
          settings: settings,
        );
      case AppRoutes.dashboard:
        return CupertinoPageRoute(
          builder: (context) => const DashboardView(),
          settings: settings,
        );
      case AppRoutes.businessProfile:
        return CupertinoPageRoute(
          builder: (context) => const BusinessProfileView(),
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
