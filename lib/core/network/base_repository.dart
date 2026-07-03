import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/domain/model/api_response.dart';

abstract class BaseRepository {
  final ApiClient apiClient;

  BaseRepository(this.apiClient);

  Future<ApiResponse<T>> post<T>({
    required String url,
    required Map<String, dynamic> body,
    required T Function(dynamic json) parser,
  }) async {
    try {
      final http.Response response = await apiClient.post(url: url, body: body);

      final dynamic decoded = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {};

      switch (response.statusCode) {
        case 200:
        case 201:
          return ApiResponse.success(
            parser(decoded),
            message: decoded["message"] ?? "Success",
            statusCode: response.statusCode,
          );

        case 400:
        case 401:
        case 404:
        case 409:
        case 422:
        case 500:
          return ApiResponse.error(
            decoded["message"] ?? "Something went wrong",
            statusCode: response.statusCode,
          );

        default:
          return ApiResponse.error(
            decoded["message"] ?? "Unexpected Error (${response.statusCode})",
            statusCode: response.statusCode,
          );
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } on HttpException {
      return ApiResponse.error("Server Error");
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
