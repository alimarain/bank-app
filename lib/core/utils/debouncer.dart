import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static void info(Object? message) {
    if (kDebugMode) {
      debugPrint('ℹ️ INFO: $message');
    }
  }

  static void success(Object? message) {
    if (kDebugMode) {
      debugPrint('✅ SUCCESS: $message');
    }
  }

  static void warning(Object? message) {
    if (kDebugMode) {
      debugPrint('⚠️ WARNING: $message');
    }
  }

  static void error(Object? message) {
    if (kDebugMode) {
      debugPrint('❌ ERROR: $message');
    }
  }

  static void api(String method, String url, int statusCode) {
    if (kDebugMode) {
      debugPrint('🌐 $method | $url | Status: $statusCode');
    }
  }
}
