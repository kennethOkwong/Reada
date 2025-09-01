import 'package:get_it/get_it.dart';
import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/features/authentication/data/data_source/remote_source/auth_remote_data_source.dart';
import 'package:reada/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/features/authentication/presentation/login_view/login_viewmodel.dart';
import 'package:reada/features/onboarding/landing_view/landing_view_viewmodel.dart';
import 'package:reada/features/authentication/presentation/register_view/register_viewmodel.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_viewmodel.dart';
import 'package:reada/features/dashboard/presentation/dashboard_viewmodel.dart';
import 'package:reada/features/stores/presentation/stores/stores_vm.dart';
import 'package:reada/services/api%20service/api.dart';

final locator = GetIt.instance;

/// Register all the controllers and services
Future<void> setUpLocator(AppFlavorConfig config) async {
  await _registerExternalDependencies(config);
  await _registerServices();
  await _registerViewmodels();
  await _registerRepositories();
}

Future<void> _registerServices() async {
  locator.registerLazySingleton<Api>(Api.new);
}

Future<void> _registerViewmodels() async {
  locator
    ..registerFactory<LandingScreenViewmodel>(LandingScreenViewmodel.new)
    ..registerFactory<LoginViewmodel>(LoginViewmodel.new)
    ..registerFactory<RegisterViewmodel>(RegisterViewmodel.new)
    ..registerFactory<ForgotPasswordViewmodel>(ForgotPasswordViewmodel.new)
    ..registerFactory<VerifyCodeViewmodel>(VerifyCodeViewmodel.new)
    ..registerFactory<StoresViewmodel>(StoresViewmodel.new)
    ..registerFactory<DashboardViewmodel>(DashboardViewmodel.new);
}

Future<void> _registerExternalDependencies(AppFlavorConfig config) async {
  locator.registerLazySingleton<AppFlavorConfig>(() => config);
}

Future<void> _registerRepositories() async {
  locator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(AuthRemoteDataSource()));
}
