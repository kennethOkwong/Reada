class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email address is required';
    }

    if (!RegExp(r'^[\w-/.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(email)) {
      return 'Invalid email ';
    }

    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return 'Phone is required';

    if (!RegExp(r'^[0-9]').hasMatch(phone) || phone.length < 10) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? validatePassword(
      [String? password, bool checkOnlyEmptyStatus = false]) {
    if (password == null || password.isEmpty) return 'Password is required';

    if (checkOnlyEmptyStatus) return null;

    // Check for at least 8 characters
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Check for an uppercase letter
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    if (!hasUppercase) {
      return "Password must contain at least one uppercase letter";
    }

    // Check for a number
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    if (!hasNumber) {
      return "Password must contain at least one number";
    }

    // // Check for a symbol
    // bool hasSymbol = password.contains(RegExp(r'[!@#\$&*~%]'));
    // if (!hasSymbol) {
    //   return (true, "Password must contain at least one symbol");
    // }

    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Field is required';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Field cannot be empty';
    }

    if (name.length < 2) {
      return 'Invalid name, must be at least 2 characters';
    }

    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(name)) {
      return 'Name cannot include special charaters';
    }

    return null;
  }

  static String? validateCode(String? code) {
    if (code == null || code.isEmpty) return 'Code is required';

    if (!RegExp(r'^[0-9]').hasMatch(code) || code.length < 4) {
      return 'Please enter a valid code';
    }

    return null;
  }
}












// class FormValidator {
//   static String? validateEmail(String? email) {
//     if (email!.isEmpty) return "Email address is required";

//     if (!RegExp(r'^[\w-/.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(email)) {
//       return "Please enter a valid email";
//     }

//     return null;
//   }


//   static (bool, String?) validatePassword(String? password) {
//     if (password!.isEmpty) return (true, "Password is required");

//     // Check for at least 8 characters
//     if (password.length < 8) {
//       return (true, "Password must have at least 8 characters");
//     }

//     // Check for an uppercase letter
//     bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
//     if (!hasUppercase) {
//       return (true, "Password must contain at least one uppercase letter");
//     }

//     // Check for a number
//     bool hasNumber = password.contains(RegExp(r'[0-9]'));
//     if (!hasNumber) {
//       return (true, "Password must contain at least one number");
//     }

//     // Check for a symbol
//     bool hasSymbol = password.contains(RegExp(r'[!@#\$&*~%]'));
//     if (!hasSymbol) {
//       return (true, "Password must contain at least one symbol");
//     }

//     return (false, null);
//   }

//   // static String? validatePassword(String? password) {
//   //   if (password!.isEmpty) return "Password is required";
//   //   String pattern =
//   //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$';
//   //   RegExp regex = RegExp(pattern);

//   //   if (!regex.hasMatch(password)) {
//   //     return '''Password must be at least 8 characters,\ninclude an uppercase letter, number and symbol.''';
//   //   }

//   //   return null;
//   // }

//   static String? checkIfPasswordSame(String? password, String? val) {
//     if (password != val) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   static String? validateName(String? name) {
//     if (name!.isEmpty) {
//       return "Field cannot be empty";
//     }

//     if (name.length < 4) {
//       return "Name must be at least 4 characters";
//     }

//     if (!RegExp(r'^[a-z A-Z]+$').hasMatch(name)) {
//       return "Are you sure that what people call you?";
//     }

//     return null;
//   }
// }
