import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/features/auth/services/auth_service.dart';

void main() {
  HttpOverrides.global = null;
  FlutterSecureStorage.setMockInitialValues({});

  final authService = AuthService();

  test('AuthService login successfully connects to live Cloud Run backend', () async {
    try {
      await authService.login(
        email: 'patient_test@example.com',
        password: 'wrong_password_123',
      );
      fail('Should fail due to invalid password');
    } catch (e) {
      expect(
        e.toString(),
        contains('Email hoặc mật khẩu không chính xác'),
      );
    }
  });

  test('AuthService forgotPassword sends OTP request to live backend', () async {
    final message = await authService.forgotPassword(email: 'test_patient@example.com');
    expect(message, isNotEmpty);
  });

  test('AuthService verifyForgotPasswordOtp validates OTP with live backend', () async {
    try {
      await authService.verifyForgotPasswordOtp(
        email: 'test_patient@example.com',
        otp: '999999',
      );
      fail('Should fail due to invalid OTP');
    } catch (e) {
      expect(e.toString(), contains('Exception:'));
    }
  });
}
