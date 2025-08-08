class ApiResponse<T> {
  ApiResponse({
    required this.isSuccessful,
    this.code,
    this.data,
    this.others,
    this.isTimeout,
    this.message,
    this.errorType,
    this.errorCode,
    this.type,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      errorType: json['type'],
      errorCode: json['code'],
      isSuccessful: json['status'] ?? false,
      data: json['data'] as T?,
    );
  }
  factory ApiResponse.timout() {
    return ApiResponse(
      isSuccessful: false,
      others: 'timeout',
      isTimeout: true,
      message: 'Error occured. Please try again later',
      data: null,
    );
  }
  dynamic code;
  T? data;
  dynamic others;
  bool isSuccessful;
  final bool? isTimeout;
  final String? message;
  final String? errorType;
  final String? errorCode;
  final String? type;
}
