class SendCodeRequestDto {
  final String? email;
  final String? codeType;

  SendCodeRequestDto({
    this.email,
    this.codeType,
  });

  SendCodeRequestDto copyWith({
    String? email,
    String? codeType,
  }) {
    return SendCodeRequestDto(
      email: email ?? this.email,
      codeType: codeType ?? this.codeType,
    );
  }

  toJson() {
    return {
      "email": email,
      "code_type": codeType,
    };
  }
}
