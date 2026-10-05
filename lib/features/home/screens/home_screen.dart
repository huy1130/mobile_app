import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Hospital Branding Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppLogo(size: 42),
                  IconButton(
                    onPressed: () {},
                    icon: const Badge(
                      label: Text('1'),
                      child: Icon(Icons.notifications_outlined, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // User Greeting
              Text(
                'Xin chào, 👋',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 2),
              Text(
                'Bệnh nhân Nguyễn Văn A',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Upcoming Appointment Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, Color(0xFF0284C7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Lịch khám sắp tới',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Khám Đa Khoa & Xét Nghiệm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.access_time, color: Colors.white70, size: 16),
                        SizedBox(width: 6),
                        Text(
                          '09:00 - 05/10/2026',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Quick Actions Section
              Text(
                'Dịch vụ y tế',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.calendar_today_rounded,
                      title: 'Đặt lịch khám',
                      subtitle: 'Chọn bác sĩ & ngày',
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.psychology_rounded,
                      title: 'Trợ lý AI',
                      subtitle: 'Khai báo triệu chứng',
                      iconBg: const Color(0xFFF0FDF4),
                      iconColor: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.description_outlined,
                      title: 'Bệnh án điện tử',
                      subtitle: 'Đơn thuốc & kết quả',
                      iconBg: const Color(0xFFFAF5FF),
                      iconColor: const Color(0xFF9333EA),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.health_and_safety_outlined,
                      title: 'Thẻ BHYT',
                      subtitle: 'Thông tin bảo hiểm',
                      iconBg: const Color(0xFFFFFBEB),
                      iconColor: const Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
