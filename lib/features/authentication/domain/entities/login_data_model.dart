class LoginDataModel {
  String? email;
  String? password;

  LoginDataModel({
    this.email,
    this.password,
  });

  toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
