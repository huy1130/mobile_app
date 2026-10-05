import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base API URL from .env (fallback to Production Cloud Run)
  static String get baseUrl {
    if (dotenv.isInitialized) {
      return dotenv.env['API_BASE_URL'] ??
          'https://healthcare-ai-capstone-727342906224.asia-east1.run.app/api/v1';
    }
    return 'https://healthcare-ai-capstone-727342906224.asia-east1.run.app/api/v1';
  }

  // Base Upload URL from .env
  static String get uploadBaseUrl {
    if (dotenv.isInitialized) {
      return dotenv.env['UPLOAD_BASE_URL'] ??
          'https://storage.googleapis.com/healthcare-ai-uploads';
    }
    return 'https://storage.googleapis.com/healthcare-ai-uploads';
  }

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyForgotPasswordOtp = '/auth/forgot-password/verify-otp';
  static const String resetPassword = '/auth/forgot-password/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';

  // User Endpoints
  static const String updateMyProfile = '/users/me';
  static const String userDetail = '/users';
  static const String profile = '/patients/profile';
  static const String appointments = '/appointments';
  static const String doctorSchedules = '/doctor-schedules';
  static const String symptomIntake = '/symptom-intake';
  static const String medicalRecords = '/medical-records';
}
