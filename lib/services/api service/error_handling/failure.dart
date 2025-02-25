class Failure {
  Failure({
    required this.message,
  });
  final String message;

  @override
  String toString() => 'Failure(message: $message)';
}

class ApiErrorHandling {
  static String getErrorMessage(String errorCode, String? errorMessage) {
    switch (errorCode) {
      case 'token_not_valid':
        return 'Session expired. Please log in again.';
      default:
        return errorMessage ?? 'An error occurred. Please try again later.';
    }
  }
}
