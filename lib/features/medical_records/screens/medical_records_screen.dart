import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ sức khỏe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.folder_shared_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Kết quả xét nghiệm & Đơn thuốc điện tử'),
          ],
        ),
      ),
    );
  }
}
