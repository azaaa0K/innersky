import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/onboarding_profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.profile, super.key});

  final OnboardingProfile profile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = (size.width / 390).clamp(0.9, 1.15);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            24 * scale,
            20 * scale,
            24 * scale,
            32 * scale,
          ),
          children: [
            Text(
              'InnerSky',
              style: GoogleFonts.playfairDisplay(
                fontSize: 42 * scale,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10 * scale),
            Text(
              'Welcome, ${profile.name ?? profile.username ?? 'Explorer'}',
              style: GoogleFonts.inter(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 28 * scale),
            Container(
              padding: EdgeInsets.all(24 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28 * scale),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF181818), Color(0xFF323232)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${profile.username ?? 'innersky'}',
                    style: GoogleFonts.spaceMono(
                      fontSize: 16 * scale,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 14 * scale),
                  Text(
                    'Your profile is ready.',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28 * scale,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10 * scale),
                  Text(
                    'Onboarding now flows from welcome to home with your birth details and username carried through each step.',
                    style: GoogleFonts.inter(
                      fontSize: 15 * scale,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22 * scale),
            _ProfileCard(
              scale: scale,
              label: 'Name',
              value: profile.name ?? 'Not provided',
            ),
            SizedBox(height: 14 * scale),
            _ProfileCard(
              scale: scale,
              label: 'Birth Date',
              value: _formatDate(profile.birthDate),
            ),
            SizedBox(height: 14 * scale),
            _ProfileCard(
              scale: scale,
              label: 'Birth Time',
              value: _formatTime(profile.birthTime),
            ),
            SizedBox(height: 14 * scale),
            _ProfileCard(
              scale: scale,
              label: 'Birth Location',
              value: profile.birthLocation ?? 'Not provided',
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime? value) {
    if (value == null) return 'Not provided';
    const months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[value.month - 1]} ${value.day}, ${value.year}';
  }

  static String _formatTime(TimeOfDay? value) {
    if (value == null) return 'Not provided';
    final period = value.hour >= 12 ? 'PM' : 'AM';
    final hour = value.hourOfPeriod == 0 ? 12 : value.hourOfPeriod;
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.scale,
    required this.label,
    required this.value,
  });

  final double scale;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.spaceMono(
              fontSize: 12 * scale,
              letterSpacing: 1.4 * scale,
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 10 * scale),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
