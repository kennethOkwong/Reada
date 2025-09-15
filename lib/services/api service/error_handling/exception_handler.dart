import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:reada/services/api%20service/error_handling/exceptions.dart';

class ExceptionHandler {
  static ReadaException mapToReadaException(dynamic error,
      [StackTrace? stackTrace]) {
    if (error is ReadaException) {
      return error;
    } else if (error is SocketException) {
      return ReadaSocketException(stackTrace: stackTrace);
    } else if (error is TimeoutException) {
      return ReadaTimeoutException(stackTrace: stackTrace);
    } else if (error is ClientException) {
      return ReadaClientException(stackTrace: stackTrace);
    } else if (error is FormatException) {
      return ReadaFormatException(stackTrace: stackTrace);
    } else if (error is Exception) {
      return ReadaUnknownException(stackTrace: stackTrace);
    } else {
      return ReadaFatalException(stackTrace: stackTrace);
    }
  }
}
