import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch khám bệnh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.calendar_month, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Danh sách lịch hẹn khám của bạn'),
          ],
        ),
      ),
    );
  }
}
