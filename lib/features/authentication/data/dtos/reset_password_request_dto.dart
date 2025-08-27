class ResetPasswordRequestDto {
  final String? email;
  final String? password;
  final String? cPassword; // Added new field

  ResetPasswordRequestDto(
      {required this.email, required this.password, required this.cPassword});

  factory ResetPasswordRequestDto.empty() {
    return ResetPasswordRequestDto(
        email: null, password: null, cPassword: null); // Updated factory
  }

  ResetPasswordRequestDto copyWith({
    String? email,
    String? password,
    String? cPassword, // Added new parameter
  }) {
    return ResetPasswordRequestDto(
      email: email ?? this.email,
      password: password ?? this.password, // Updated to include password
      cPassword: cPassword ?? this.cPassword, // Added new field
    );
  }

  toJson() {
    return {
      'email': email?.trim().toLowerCase(),
      'new_password': password,
    };
  }
}
