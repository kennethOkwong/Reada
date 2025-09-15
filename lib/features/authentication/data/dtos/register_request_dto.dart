import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/shared/enums/user_type_enum.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class RegisterRequestDto {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? confirmPassword;

  RegisterRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterRequestDto.empty() {
    return RegisterRequestDto(
      firstName: null,
      lastName: null,
      email: null,
      phone: null,
      password: null,
      confirmPassword: null,
    );
  }

  RegisterRequestDto copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterRequestDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phone,
      "password": password,
      "user_type": UserType.vendor.name,
    };
  }

  SendCodeRequestDto toSendCodeDto() {
    return SendCodeRequestDto(
      email: email,
      codeType: CodeType.userVerification.readableName,
    );
  }

  LoginRequestDto toLoginDto() {
    return LoginRequestDto(email: email, password: password);
  }
}
