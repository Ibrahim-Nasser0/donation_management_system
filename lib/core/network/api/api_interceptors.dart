import 'package:dio/dio.dart';
import 'package:donation_management_system/core/routes/app_router.dart';
import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/features/auth/data/data_source/user_local_data_source.dart';
import 'package:flutter/foundation.dart';

/// API Interceptor for handling requests, responses, and errors
/// Provides centralized logging and error handling
class ApiInterceptor extends Interceptor {
  final UserLocalDataSource userLocalDataSource;

  ApiInterceptor({required this.userLocalDataSource});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request details
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('📤 REQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Query Parameters: ${options.queryParameters}');
    debugPrint('Body: ${options.data}');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response details
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint(
      '📥 RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    debugPrint('Data: ${response.data}');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error details
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    debugPrint('Message: ${err.message}');
    debugPrint('Response: ${err.response?.data}');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    // Handle Unauthorized (401)
    if (err.response?.statusCode == 401) {
      _handleLogout();
    }

    super.onError(err, handler);
  }

  void _handleLogout() async {
    debugPrint('🚨 Status 401 detected: Logging out user and clearing data.');

    // Clear local user data
    await userLocalDataSource.deleteToken();
    await userLocalDataSource.deleteUserId();

    // Redirect to login
    AppRouter.router.go(Routes.login);
  }
}

/// Authentication Interceptor
/// Automatically adds authentication token to requests
class AuthInterceptor extends Interceptor {
  final Future<String?> Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
