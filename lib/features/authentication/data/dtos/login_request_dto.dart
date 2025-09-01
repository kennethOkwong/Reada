import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class LoginRequestDto {
  final String? email;
  final String? password;

  LoginRequestDto({
    required this.email,
    required this.password,
  });

  factory LoginRequestDto.empty() {
    return LoginRequestDto(email: null, password: null);
  }

  LoginRequestDto copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequestDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  SendCodeRequestDto toSendCodeDto() {
    return SendCodeRequestDto(
      codeType: CodeType.userVerification.readableName,
      email: email,
    );
  }
}
