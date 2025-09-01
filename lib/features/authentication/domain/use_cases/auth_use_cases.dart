import 'package:reada/app/locator.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/create_business_profile_usecase.dart';
import 'package:reada/features/authentication/domain/use_cases/get_user_from_api_usecase.dart';
import 'package:reada/features/authentication/domain/use_cases/get_user_from_local_storage_usecase.dart';
import 'package:reada/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/reset_password_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/save_user_to_local_storage_usecase.dart';
import 'package:reada/features/authentication/domain/use_cases/send_code_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/verify_code_use_case.dart';

final _authRepository = locator<AuthRepository>();

///usecases
final registerUseCase = RegisterUseCase(_authRepository);
final sendCodeUseCase = SendCodeUseCase(_authRepository);
final verifyCodeUseCase = VerifyCodeUseCase(_authRepository);
final loginUseCase = LoginUseCase(_authRepository);
final resetPasswordUseCase = ResetPasswordUseCase(_authRepository);
final createBusinessProfileUsecase =
    CreateBusinessProfileUsecase(_authRepository);
final getUserFromApiUsecase = GetUserFromApiUsecase(_authRepository);
final getUserFromLocalStorageUsecase =
    GetUserFromLocalStorageUsecase(_authRepository);
final saveUserToLocalStorageUsecase =
    SaveUserToLocalStorageUsecase(_authRepository);
