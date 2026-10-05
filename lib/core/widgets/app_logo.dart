import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? textColor;

  const AppLogo({
    super.key,
    this.size = 48,
    this.showText = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.local_hospital, color: Color(0xFF0B3C8F));
          },
        ),
      ),
    );

    if (!showText) {
      return logoWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoWidget,
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bệnh viện Đa khoa 4AM',
              style: TextStyle(
                fontSize: size * 0.35 > 15 ? 16 : 14,
                fontWeight: FontWeight.w800,
                color: textColor ?? const Color(0xFF0B3C8F),
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Hệ thống Y tế uy tín',
              style: TextStyle(
                fontSize: size * 0.25 > 12 ? 12 : 11,
                fontWeight: FontWeight.w500,
                color: (textColor ?? const Color(0xFF0B3C8F)).withValues(alpha: 0.65),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
