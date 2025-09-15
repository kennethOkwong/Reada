import 'package:reada/app/app_strings/error_strings.dart';

/// Base exception for all Reada-related errors
abstract class ReadaException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ReadaException(
      {this.message = "An unexpected error occurred", this.stackTrace});

  @override
  String toString() => message;
}

/// --------------------
/// Network & API Errors
/// --------------------

/// No internet connection
class ReadaSocketException extends ReadaException {
  const ReadaSocketException(
      {String message = "No internet connection", StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

/// Request timeout
class ReadaTimeoutException extends ReadaException {
  const ReadaTimeoutException(
      {String message = "The request timed out", StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

/// Failed to connect to server (client-side issue)
class ReadaClientException extends ReadaException {
  const ReadaClientException(
      {String message = "There was a problem connecting to the server",
      StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

class ReadaFormatException extends ReadaException {
  const ReadaFormatException(
      {String message = "A required field is missing", StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

class ReadaInacticeUserException extends ReadaException {
  const ReadaInacticeUserException(
      {String message = ErrorStrings.inactiveUser, StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

/// API responded with a "false" success flag.
/// Network was fine, server responded, but operation failed.
class ReadaFalseApiResponseException extends ReadaException {
  final int? statusCode;

  ReadaFalseApiResponseException({
    String? message,
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(message: message ?? "The request failed", stackTrace: stackTrace);
}

class ReadaLocalStorageNoDataException extends ReadaException {
  ReadaLocalStorageNoDataException({
    String? message,
    StackTrace? stackTrace,
  }) : super(
            message: message ?? "Data not found in local storage",
            stackTrace: stackTrace);
}

/// --------------------
/// Generic / Fallback
/// --------------------

class ReadaUnknownException extends ReadaException {
  const ReadaUnknownException(
      {String message = "An unknown error occurred", StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}

//dart and flutter errors that are not exceptions
class ReadaFatalException extends ReadaException {
  const ReadaFatalException(
      {String message = "A fatal error occurred", StackTrace? stackTrace})
      : super(message: message, stackTrace: stackTrace);
}
