import 'package:get_it/get_it.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/features/authentication/presentation/landing%20screen/landing_screen_viewmodel.dart';
import 'package:reada/features/authentication/presentation/login%20screen/login_viewmodel.dart';
import 'package:reada/features/authentication/presentation/register%20screen/register_viewmodel.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_viewmodel.dart';
import 'package:reada/services/navigation%20service/navigation_service.dart';

final locator = GetIt.instance;

/// Register all the controllers and services
Future<void> setUpLocator() async {
  // await _registerExternalDependencies(config);
  await _registerServices();
  await _registerViewmodels();
  await _registerRepositories();
}

Future<void> _registerServices() async {
  locator..registerLazySingleton<NavigationService>(NavigationService.new);
  // ..registerLazySingleton<Api>(Api.new)
}

Future<void> _registerViewmodels() async {
  locator
    ..registerFactory<LandingScreenViewmodel>(LandingScreenViewmodel.new)
    ..registerFactory<LoginViewmodel>(LoginViewmodel.new)
    ..registerFactory<RegisterViewmodel>(RegisterViewmodel.new)
    ..registerFactory<ForgotPasswordViewmodel>(ForgotPasswordViewmodel.new)
    ..registerFactory<VerifyCodeViewmodel>(VerifyCodeViewmodel.new);
}

// Future<void> _registerExternalDependencies(AppFlavorConfig config) async {
//   locator.registerLazySingleton<AppFlavorConfig>(() => config);
//   final instance = await SharedPreferences.getInstance();
//   locator.registerLazySingleton<SharedPreferences>(() => instance);
//   final intercom = Intercom.instance;
//   locator.registerLazySingleton<Intercom>(() => intercom);
// }

Future<void> _registerRepositories() async {}
