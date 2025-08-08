class RegisterUserDataModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? confirmPassword;

  RegisterUserDataModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterUserDataModel.empty() {
    return RegisterUserDataModel(
      firstName: null,
      lastName: null,
      email: null,
      phone: null,
      password: null,
      confirmPassword: null,
    );
  }

  RegisterUserDataModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterUserDataModel(
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
      "user_type": 'vendor',
    };
  }
}
