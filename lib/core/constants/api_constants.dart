class ApiConstants {
  // Production Cloud Run API
  static const String baseUrlProd =
      'https://healthcare-ai-capstone-727342906224.asia-east1.run.app/api/v1';

  // Local Development (10.0.2.2 for Android Emulator, localhost for iOS/Web)
  static const String baseUrlLocal = 'http://10.0.2.2:3000/api/v1';

  // Current active base URL (mặc định dùng Prod để test được ngay trên cả máy ảo & máy thật)
  static const String baseUrl = baseUrlProd;

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/patients/profile';
  static const String appointments = '/appointments';
  static const String doctorSchedules = '/doctor-schedules';
  static const String symptomIntake = '/symptom-intake';
  static const String medicalRecords = '/medical-records';
}
