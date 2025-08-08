class VerifyCodeDataModel {
  String? email;
  String? code;
  String? codeType;

  VerifyCodeDataModel({
    this.email,
    this.code,
    this.codeType,
  });

  toJson() {
    return {
      "email": email,
      "code": code,
      "code_type": codeType,
    };
  }
}
