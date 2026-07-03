class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
  });

  factory ApiResponse.success(
    T? data, {
    String message = "Success",
    int? statusCode = 200,
  }) {
    return ApiResponse<T>(
      success: true,
      message: message,
      data: data,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
