class SendCodeDataModel {
  String? email;
  String? codeType;

  SendCodeDataModel({
    this.email,
    this.codeType,
  });

  toJson() {
    return {
      "email": email,
      "code_type": codeType,
    };
  }
}
