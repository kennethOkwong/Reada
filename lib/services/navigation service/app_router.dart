import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_view.dart';
import 'package:reada/features/authentication/presentation/login_view/login_view.dart';
import 'package:reada/features/authentication/presentation/verify code/verify_code_view.dart';
import 'package:reada/features/authentication/presentation/forgot password/enter_email_view.dart';
import 'package:reada/features/authentication/presentation/forgot password/reset_password_view.dart';
import 'package:reada/features/authentication/presentation/register_view/register_view.dart';
import 'package:reada/features/dashboard/presentation/dashboard_view.dart';
import 'package:reada/features/onboarding/landing_view/landing_view.dart';
import 'package:reada/features/onboarding/splash_view.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => SplashView(
          screenSize: MediaQuery.of(context).size,
        ),
      ),
      GoRoute(
        path: AppRoutes.intro,
        builder: (context, state) => const LandingView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRoutes.enterEmail,
        builder: (context, state) => const EnterEmailView(),
      ),
      GoRoute(
        path: AppRoutes.enterCode,
        builder: (context, state) {
          final args = state.extra as SendCodeRequestDto;
          return EnterCodeView(codeModel: args);
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final email = state.extra as String;
          return ResetPasswordView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: AppRoutes.businessProfile,
        builder: (context, state) => const BusinessProfileView(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Path not defined'),
      ),
    ),
  );
}
