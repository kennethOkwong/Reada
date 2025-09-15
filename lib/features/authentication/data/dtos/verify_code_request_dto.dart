class VerifyCodeRequestDto {
  final String? email;
  final String? code;
  final String? codeType;

  VerifyCodeRequestDto({
    required this.email,
    required this.code,
    required this.codeType,
  });

  factory VerifyCodeRequestDto.empty() {
    return VerifyCodeRequestDto(
      email: null,
      code: null,
      codeType: null,
    );
  }

  VerifyCodeRequestDto copyWith({
    String? email,
    String? code,
    String? codeType,
  }) {
    return VerifyCodeRequestDto(
      email: email ?? this.email,
      code: code ?? this.code,
      codeType: codeType ?? this.codeType,
    );
  }

  toJson() {
    return {
      "email": email,
      "code": code,
      "code_type": codeType,
    };
  }
}
