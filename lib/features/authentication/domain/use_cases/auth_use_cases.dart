import 'package:reada/app/locator.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/reset_password_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/send_code_use_case.dart';
import 'package:reada/features/authentication/domain/use_cases/verify_code_use_case.dart';

final _authRepository = locator<AuthRepository>();
final registerUseCase = RegisterUseCase(_authRepository);
final sendCodeUseCase = SendCodeUseCase(_authRepository);
final verifyCodeUseCase = VerifyCodeUseCase(_authRepository);
final loginUseCase = LoginUseCase(_authRepository);
final resetPasswordUseCase = ResetPasswordUseCase(_authRepository);
