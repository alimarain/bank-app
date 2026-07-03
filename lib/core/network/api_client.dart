import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return await _client
        .post(
          Uri.parse(url),
          headers:
              headers ??
              {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
          body: jsonEncode(body ?? {}),
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await _client
        .get(Uri.parse(url), headers: headers ?? {"Accept": "application/json"})
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> put({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return await _client
        .put(
          Uri.parse(url),
          headers:
              headers ??
              {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
          body: jsonEncode(body ?? {}),
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await _client
        .delete(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 10));
  }
}
