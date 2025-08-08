class UserModel {
  String userId = '';
  String email = '';

  UserModel({
    required this.userId,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    email = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
    };
  }
}
