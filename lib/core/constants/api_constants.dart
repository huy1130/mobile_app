import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base API URL from .env (fallback to Production Cloud Run)
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ??
      'https://healthcare-ai-capstone-727342906224.asia-east1.run.app/api/v1';

  // Base Upload URL from .env
  static String get uploadBaseUrl =>
      dotenv.env['UPLOAD_BASE_URL'] ??
      'https://storage.googleapis.com/healthcare-ai-uploads';

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/patients/profile';
  static const String appointments = '/appointments';
  static const String doctorSchedules = '/doctor-schedules';
  static const String symptomIntake = '/symptom-intake';
  static const String medicalRecords = '/medical-records';
}
