import 'package:reada/services/api%20service/error_handling/exceptions.dart';
import 'package:reada/shared/typedefs.dart';

class ApiResponse {
  bool isSuccessful;
  dynamic code;
  dynamic data;
  final String? message;

  ApiResponse({
    required this.isSuccessful,
    this.code,
    this.data,
    this.message,
  });

  factory ApiResponse.fromJson(JSON json) {
    return ApiResponse(
      message: json['message'],
      isSuccessful: json['status'] ?? false,
      data: json['data'],
    );
  }

  ReadaFalseApiResponseException toReadaFalseApiResponseException() {
    return ReadaFalseApiResponseException(message: message, statusCode: code);
  }
}
