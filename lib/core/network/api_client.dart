import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add JWT Token Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _storage.read(key: 'access_token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (_) {}
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // Handle 401 Unauthorized (e.g. token expired)
          if (error.response?.statusCode == 401) {
            try {
              await _storage.delete(key: 'access_token');
            } catch (_) {}
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Token Helpers
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'access_token', value: token);
    } catch (_) {}
  }

  Future<void> saveUserInfo({required String name, required String email}) async {
    try {
      await _storage.write(key: 'user_full_name', value: name);
      await _storage.write(key: 'user_email', value: email);
    } catch (_) {}
  }

  Future<String?> getUserFullName() async {
    try {
      return await _storage.read(key: 'user_full_name');
    } catch (_) {
      return null;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      return await _storage.read(key: 'user_email');
    } catch (_) {
      return null;
    }
  }

  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'access_token');
    } catch (_) {
      return null;
    }
  }

  Future<void> clearToken() async {
    try {
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'user_full_name');
      await _storage.delete(key: 'user_email');
    } catch (_) {}
  }
}
