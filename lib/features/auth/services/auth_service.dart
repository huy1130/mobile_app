import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../models/auth_user.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  String _handleError(dynamic error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map && responseData.containsKey('message')) {
        final message = responseData['message'];
        if (message is List) {
          return message.join(', ');
        }
        return message.toString();
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return 'Hết thời gian kết nối đến máy chủ. Vui lòng thử lại!';
      }
      if (error.type == DioExceptionType.connectionError) {
        return 'Không thể kết nối đến máy chủ. Kiểm tra mạng internet!';
      }
    }
    return 'Đã có lỗi xảy ra. Vui lòng thử lại sau!';
  }

  // Đăng nhập
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.login,
        data: {
          'email': email.trim(),
          'password': password,
        },
      );

      final data = response.data;
      final accessToken = data['accessToken'] ?? data['access_token'];
      if (accessToken != null) {
        await _apiClient.saveToken(accessToken);
      }

      final user = AuthUser.fromJson(data['user'] ?? {});
      await _apiClient.saveUserInfo(
        name: user.fullName,
        email: user.email,
      );

      return user;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Đăng ký bước 1
  Future<String> register({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.register,
        data: {
          'email': email.trim(),
          'password': password,
          'fullName': fullName.trim(),
          if (phoneNumber != null && phoneNumber.isNotEmpty)
            'phoneNumber': phoneNumber.trim(),
        },
      );
      return response.data['message'] ?? 'Mã xác thực OTP đã được gửi đến email của bạn';
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Đăng ký bước 2: Xác thực OTP
  Future<AuthUser> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.verifyOtp,
        data: {
          'email': email.trim(),
          'otp': otp.trim(),
        },
      );
      return AuthUser.fromJson(response.data['user'] ?? {});
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Quên mật khẩu - Bước 1: Gửi OTP
  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.forgotPassword,
        data: {
          'email': email.trim(),
        },
      );
      return response.data['message'] ?? 'Mã xác thực OTP đã được gửi đến email của bạn';
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Quên mật khẩu - Bước 2: Xác thực OTP -> nhận resetToken
  Future<String> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.verifyForgotPasswordOtp,
        data: {
          'email': email.trim(),
          'otp': otp.trim(),
        },
      );
      final resetToken = response.data['resetToken'] ?? '';
      return resetToken;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Quên mật khẩu - Bước 3: Đặt mật khẩu mới
  Future<String> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.resetPassword,
        data: {
          'resetToken': resetToken,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        },
      );
      return response.data['message'] ?? 'Đặt lại mật khẩu thành công!';
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Đổi mật khẩu (yêu cầu đăng nhập, thu hồi toàn bộ session)
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        },
      );
      return response.data['message'] ?? 'Đổi mật khẩu thành công!';
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Cấp lại access token mới bằng refresh token
  Future<String> refreshToken(String refreshToken) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.refreshToken,
        data: {
          'refreshToken': refreshToken,
        },
      );
      final newAccessToken = response.data['accessToken'] ?? '';
      if (newAccessToken.isNotEmpty) {
        await _apiClient.saveToken(newAccessToken);
      }
      return newAccessToken;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Cập nhật profile người dùng hiện tại (PATCH /users/me)
  Future<AuthUser> updateMyProfile({
    String? fullName,
    String? phoneNumber,
    String? address,
    String? gender,
    String? dateOfBirth,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        ApiConstants.updateMyProfile,
        data: {
          if (fullName != null) 'fullName': fullName.trim(),
          if (phoneNumber != null) 'phoneNumber': phoneNumber.trim(),
          if (address != null) 'address': address.trim(),
          'gender': ?gender,
          'dateOfBirth': ?dateOfBirth,
        },
      );
      final user = AuthUser.fromJson(response.data['user'] ?? response.data);
      if (fullName != null) {
        await _apiClient.saveUserInfo(name: user.fullName, email: user.email);
      }
      return user;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    try {
      await _apiClient.dio.post(ApiConstants.logout);
    } catch (_) {}
    await _apiClient.clearToken();
  }
}
