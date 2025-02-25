enum ApiStatus {
  success,
  failure,
}

class ApiResponse {
  ApiResponse({
    required this.isSuccessful,
    this.code,
    this.data,
    this.others,
    this.isTimeout,
    this.message,
    this.token,
    this.errorType,
    this.errorCode,
    this.type,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ??
          // ApiErrorHandling.getErrorMessage(
          //   json['code'],
          json['error'],
      // )
      // ,
      errorType: json['type'],
      errorCode: json['code'],
      isSuccessful: json['success'] ?? false,
      data: json['data'] != null
          ? (json['data'] is bool && json['data'] != false)
              ? json['data']
              : null
          : json['results'],
      token: json['token'],
    );
  }
  factory ApiResponse.timout() {
    return ApiResponse(
      isSuccessful: false,
      others: 'timeout',
      isTimeout: true,
      message: 'Error occured. Please try again later',
    );
  }
  dynamic code;
  dynamic data;
  dynamic others;
  bool isSuccessful;
  final bool? isTimeout;
  final String? message;
  final String? errorType;
  final String? errorCode;
  final String? token;
  final String? type;
}
