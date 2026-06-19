import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_typography.dart';
import '../../core/onboarding_profile.dart';
import '../../shared/widgets/app_primary_button.dart';
import '../../shared/widgets/onboarding_close_button.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import 'enter_birth_location_screen.dart';

class EnterBirthTimeScreen extends StatefulWidget {
  const EnterBirthTimeScreen({required this.profile, super.key});

  final OnboardingProfile profile;

  @override
  State<EnterBirthTimeScreen> createState() => _EnterBirthTimeScreenState();
}

class _EnterBirthTimeScreenState extends State<EnterBirthTimeScreen> {
  static const String _assetBase = 'assets/welcome';

  late TimeOfDay _selectedTime;
  bool _isContinuing = false;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.profile.birthTime ?? const TimeOfDay(hour: 9, minute: 45); // Default/loaded birth time
  }

  void _onTimeChanged(TimeOfDay newTime) {
    setState(() => _selectedTime = newTime);
  }

  Future<void> _continue() async {
    if (_isContinuing) return;
    setState(() => _isContinuing = true);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EnterBirthLocationScreen(
          profile: widget.profile.copyWith(birthTime: _selectedTime),
        ),
      ),
    );

    if (!mounted) return;
    setState(() => _isContinuing = false);
  }

  String get _formattedTime {
    final hour = _selectedTime.hourOfPeriod == 0
        ? 12
        : _selectedTime.hourOfPeriod;
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    final period = _selectedTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final w = screenSize.width;
    final h = screenSize.height;
    final s = _s(context, 1);
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundPrimary,
        body: SizedBox.expand(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(color: AppColors.backgroundPrimary),
              // Background elements (kept as-is)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.13,
                  child: Image.asset(
                    '$_assetBase/cosmic.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.12),
                      radius: 0.96,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFF9F9F8),
                        Color(0xFFF3F3F2),
                      ],
                      stops: [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xF8FFFFFF),
                        Color(0xE8FFFFFF),
                        Color(0xD0FFFFFF),
                        Color(0xF3FFFFFF),
                      ],
                      stops: [0.0, 0.34, 0.70, 1.0],
                    ),
                  ),
                ),
              ),

              // Social heading
              Positioned(
                left: _x(w, 54),
                top: topPadding + _y(h, 36),
                child: Text(
                  'Posting to social?\nTag us, we\'re @innersky',
                  style: AppTypography.socialHeader(s),
                ),
              ),

              // Close button
              Positioned(
                right: _x(w, 42),
                top: topPadding + _y(h, 30),
                child: OnboardingCloseButton(
                  scale: s,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),

              // Decorative stars (kept)
              Positioned(
                left: _x(w, 142),
                top: topPadding + _y(h, 300),
                child: _DecorativeStar(
                  assetPath: '$_assetBase/black_star.svg',
                  size: _s(context, 24),
                  opacity: 0.16,
                ),
              ),
              Positioned(
                left: _x(w, 92),
                top: topPadding + _y(h, 360),
                child: _DecorativeStar(
                  assetPath: '$_assetBase/black_star.svg',
                  size: _s(context, 30),
                  opacity: 0.16,
                ),
              ),
              Positioned(
                right: _x(w, 162),
                top: topPadding + _y(h, 296),
                child: _DecorativeStar(
                  assetPath: '$_assetBase/black_star.svg',
                  size: _s(context, 24),
                  opacity: 0.18,
                ),
              ),
              Positioned(
                right: _x(w, 98),
                top: topPadding + _y(h, 372),
                child: _DecorativeStar(
                  assetPath: '$_assetBase/black_star.svg',
                  size: _s(context, 30),
                  opacity: 0.18,
                ),
              ),

              // Moon + Title
              Positioned(
                left: 0,
                right: 0,
                top: topPadding + _y(h, 216),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      '$_assetBase/time_moon.svg.svg',
                      width: _s(context, 112),
                      height: _s(context, 112),
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: _y(h, 26)),
                    Text('STEP  3  OF  5', style: AppTypography.stepLabel(s)),
                    SizedBox(height: _y(h, 26)),
                    Text(
                      'ENTER YOUR BIRTH TIME',
                      style: AppTypography.screenTitle(s),
                    ),
                    SizedBox(height: _y(h, 18)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _x(w, 140)),
                      child: Text(
                        'This helps us calculate your ascendant and houses.',
                        textAlign: TextAlign.center,
                        style: AppTypography.subtitle(s),
                      ),
                    ),
                  ],
                ),
              ),

              // === NEW GLASSY TIME PICKER ===
              Positioned(
                left: _x(w, 32),
                right: _x(w, 32),
                top: topPadding + _y(h, 520),
                child: GlassTimePicker(
                  initialTime: _selectedTime,
                  onTimeChanged: _onTimeChanged,
                  width: w - _x(w, 64),
                ),
              ),

              // Selected time display
              Positioned(
                left: 0,
                right: 0,
                bottom: bottomPadding + _y(h, 320),
                child: Column(
                  children: [
                    Text(
                      _formattedTime,
                      style: GoogleFonts.spaceMono(
                        fontSize: _s(context, 40),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF101010),
                        letterSpacing: _s(context, 0.8),
                      ),
                    ),
                    SizedBox(height: _y(h, 12)),
                    Text(
                      'Local Time',
                      style: AppTypography.helperText(
                        s,
                      ).copyWith(color: const Color(0xFFAAAAAA)),
                    ),
                  ],
                ),
              ),

              // Privacy
              Positioned(
                left: _x(w, 88),
                right: _x(w, 88),
                bottom: bottomPadding + _y(h, 218),
                child: _PrivacyCopy(
                  scale: s,
                  assetPath: '$_assetBase/lock.svg',
                ),
              ),

              // Continue button
              Positioned(
                left: _x(w, AppSizes.ctaHorizontalInset),
                right: _x(w, AppSizes.ctaHorizontalInset),
                bottom: bottomPadding + _y(h, AppSizes.ctaBottomInset),
                child: AppPrimaryButton(
                  label: _isContinuing ? 'OPENING' : 'CONTINUE',
                  scale: s,
                  isEnabled: !_isContinuing,
                  onPressed: _continue,
                ),
              ),

              // Progress
              Positioned(
                left: 0,
                right: 0,
                bottom: math.max(
                  _y(h, AppSizes.progressBottomInset),
                  bottomPadding + 8,
                ),
                child: OnboardingProgressIndicator(
                  currentStep: 3,
                  totalSteps: 5,
                  scale: s,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _x(double screenWidth, double value) => screenWidth * (value / 832);
  double _y(double screenHeight, double value) => screenHeight * (value / 1792);
  double _s(BuildContext context, double value) {
    final size = MediaQuery.sizeOf(context);
    final scale = math.min(size.width / 832, size.height / 1792);
    return value * scale;
  }
}

// ==================== GLASSY TIME PICKER WIDGET ====================

class GlassTimePicker extends StatefulWidget {
  const GlassTimePicker({
    super.key,
    this.initialTime,
    this.onTimeChanged,
    this.width = 340,
  });

  final TimeOfDay? initialTime;
  final Function(TimeOfDay)? onTimeChanged;
  final double width;

  @override
  State<GlassTimePicker> createState() => _GlassTimePickerState();
}

class _GlassTimePickerState extends State<GlassTimePicker> {
  late TimeOfDay _selectedTime;
  bool _isAM = true; // For visual demo
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? const TimeOfDay(hour: 10, minute: 45);
    _isAM = _selectedTime.hour < 12;

    final initialHour = _selectedTime.hourOfPeriod % 12;
    final initialMinute = (_selectedTime.minute / 5).round() % 12;

    _hourController = FixedExtentScrollController(initialItem: initialHour);
    _minuteController = FixedExtentScrollController(initialItem: initialMinute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _updateTime(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime;
      _isAM = newTime.hour < 12;
    });
    widget.onTimeChanged?.call(newTime);
  }

  @override
  Widget build(BuildContext context) {
    final hour = _selectedTime.hourOfPeriod == 0
        ? 12
        : _selectedTime.hourOfPeriod;
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    return Center(
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.all(24), // Good padding on all sides
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.15),
              Colors.white.withValues(alpha: 0.05),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top tabs (adapted for time)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTab("Hourly", true),
                      _buildTab("Custom", false),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Big Time Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "$hour:$minute",
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => _isAM = true);
                            _updateTime(
                              TimeOfDay(
                                hour: _selectedTime.hour % 12,
                                minute: _selectedTime.minute,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _isAM
                                  ? Colors.white.withValues(alpha: 0.3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "AM",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() => _isAM = false);
                            _updateTime(
                              TimeOfDay(
                                hour: (_selectedTime.hour % 12) + 12,
                                minute: _selectedTime.minute,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: !_isAM
                                  ? Colors.white.withValues(alpha: 0.3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "PM",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Hour & Minute selectors (horizontal scrollable for demo)
                Row(
                  children: [
                    // Hour selector
                    Expanded(
                      child: _buildTimeScroller(
                        label: "Hour",
                        current: hour,
                        controller: _hourController,
                        onChanged: (newHour) {
                          int h24 = newHour == 12
                              ? (_isAM ? 0 : 12)
                              : (_isAM ? newHour : newHour + 12);
                          final newTime = TimeOfDay(
                            hour: h24,
                            minute: _selectedTime.minute,
                          );
                          _updateTime(newTime);
                        },
                        items: List.generate(12, (i) => i == 0 ? 12 : i),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Minute selector
                    Expanded(
                      child: _buildTimeScroller(
                        label: "Minute",
                        current: _selectedTime.minute,
                        controller: _minuteController,
                        onChanged: (newMinute) {
                          final newTime = TimeOfDay(
                            hour: _selectedTime.hour,
                            minute: newMinute,
                          );
                          _updateTime(newTime);
                        },
                        items: List.generate(
                          12,
                          (i) => i * 5,
                        ), // 5 minute steps
                        isMinute: true,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildTimeScroller({
    required String label,
    required int current,
    required FixedExtentScrollController controller,
    required Function(int) onChanged,
    required List<int> items,
    bool isMinute = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 48,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) => onChanged(items[index]),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final value = items[index % items.length];
                final isSelected = value == current;
                return Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: TextStyle(
                      fontSize: isSelected ? 32 : 24,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.6),
                    ),
                    child: Text(
                      isMinute
                          ? value.toString().padLeft(2, '0')
                          : value.toString(),
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _DecorativeStar extends StatelessWidget {
  const _DecorativeStar({
    required this.assetPath,
    required this.size,
    required this.opacity,
  });

  final String assetPath;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SvgPicture.asset(assetPath, width: size, height: size),
    );
  }
}

class _PrivacyCopy extends StatelessWidget {
  const _PrivacyCopy({required this.scale, required this.assetPath});

  final double scale;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetPath,
          width: 14 * scale,
          height: 14 * scale,
          colorFilter: const ColorFilter.mode(
            Color(0xFF666666),
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 6 * scale),
        Text(
          'Your data stays private.',
          style: TextStyle(
            color: const Color(0xFF666666),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}
