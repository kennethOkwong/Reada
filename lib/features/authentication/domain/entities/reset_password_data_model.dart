class ResetPasswordDataModel {
  String? email;
  String? password;

  ResetPasswordDataModel({this.email, this.password});

  toJson() {
    return {
      'email': email?.trim().toLowerCase(),
      'new_password': password,
    };
  }
}
