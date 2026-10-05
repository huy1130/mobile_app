import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/main_navigation/screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthcarePatientApp());
}

class HealthcarePatientApp extends StatelessWidget {
  const HealthcarePatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare AI - Bệnh nhân',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}
