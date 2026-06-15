import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterBirthDateScreen extends StatefulWidget {
  const EnterBirthDateScreen({super.key});

  @override
  State<EnterBirthDateScreen> createState() => _EnterBirthDateScreenState();
}

class _EnterBirthDateScreenState extends State<EnterBirthDateScreen> {
  static const String _assetBase = 'assets/welcome';

  final List<int> _days = List.generate(31, (index) => index + 1);

  final List<String> _months = const [
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

  final List<int> _years = List.generate(90, (index) => 1960 + index);

  late final FixedExtentScrollController _dayController;
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _yearController;

  int _selectedDayIndex = 17; // 18
  int _selectedMonthIndex = 2; // March
  int _selectedYearIndex = 40; // 2000

  double _x(double screenWidth, double value) {
    return screenWidth * (value / 832);
  }

  double _y(double screenHeight, double value) {
    return screenHeight * (value / 1792);
  }

  double _s(BuildContext context, double value) {
    final size = MediaQuery.sizeOf(context);
    final scale = math.min(size.width / 832, size.height / 1792);
    return value * scale;
  }

  @override
  void initState() {
    super.initState();

    _dayController = FixedExtentScrollController(
      initialItem: _selectedDayIndex,
    );

    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonthIndex,
    );

    _yearController = FixedExtentScrollController(
      initialItem: _selectedYearIndex,
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    final topPad = MediaQuery.paddingOf(context).top;
    final botPad = MediaQuery.paddingOf(context).bottom;

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFCFCFB),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Container(color: const Color(0xFFFCFCFB)),

              /// Soft background light
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.08),
                      radius: 0.98,
                      colors: [
                        Colors.white.withOpacity(0.98),
                        const Color(0xFFFAFAF9).withOpacity(0.92),
                        const Color(0xFFF4F4F3).withOpacity(0.72),
                      ],
                    ),
                  ),
                ),
              ),

              /// Top social text
              Positioned(
                left: _x(w, 56),
                top: topPad + _y(h, 42),
                child: Text(
                  'Posting to social?\nTag us, we’re @costarastrology!',
                  style: GoogleFonts.spaceMono(
                    fontSize: _s(context, 23),
                    height: 1.42,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: _s(context, 0.2),
                  ),
                ),
              ),

              /// Close icon
              Positioned(
                right: _x(w, 50),
                top: topPad + _y(h, 55),
                child: SvgPicture.asset(
                  '$_assetBase/close.svg',
                  width: _s(context, 34),
                  height: _s(context, 34),
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              /// Title
              Positioned(
                left: 0,
                right: 0,
                top: topPad + _y(h, 230),
                child: Text(
                  "WHAT'S YOUR BIRTH DATE?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceMono(
                    fontSize: _s(context, 23),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4B4B4B),
                    letterSpacing: _s(context, 2.2),
                  ),
                ),
              ),

              /// Birth date picker with curved columns
              Positioned(
                left: _x(w, 76),
                right: _x(w, 76),
                top: topPad + _y(h, 382),
                height: _y(h, 930),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _CurvedLinesPainter(),
                      ),
                    ),

                    /// Labels
                    Positioned(
                      left: _x(w, 96),
                      top: _y(h, 338),
                      child: _PickerLabel(
                        text: 'DAY',
                        s: _s(context, 1),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _y(h, 338),
                      child: Center(
                        child: _PickerLabel(
                          text: 'MONTH',
                          s: _s(context, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      right: _x(w, 96),
                      top: _y(h, 338),
                      child: _PickerLabel(
                        text: 'YEAR',
                        s: _s(context, 1),
                      ),
                    ),

                    /// Day curved wheel
                    Positioned(
                      left: _x(w, 70),
                      top: _y(h, 395),
                      width: _x(w, 130),
                      height: _y(h, 275),
                      child: _CurvedBirthWheel<int>(
                        controller: _dayController,
                        items: _days,
                        selectedIndex: _selectedDayIndex,
                        textBuilder: (value) => value.toString(),
                        curveType: _WheelCurveType.left,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedDayIndex = index;
                          });
                        },
                        s: _s(context, 1),
                      ),
                    ),

                    /// Month curved wheel
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _y(h, 395),
                      height: _y(h, 275),
                      child: Center(
                        child: SizedBox(
                          width: _x(w, 270),
                          child: _CurvedBirthWheel<String>(
                            controller: _monthController,
                            items: _months,
                            selectedIndex: _selectedMonthIndex,
                            textBuilder: (value) => value,
                            curveType: _WheelCurveType.middle,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                _selectedMonthIndex = index;
                              });
                            },
                            s: _s(context, 1),
                          ),
                        ),
                      ),
                    ),

                    /// Year curved wheel
                    Positioned(
                      right: _x(w, 55),
                      top: _y(h, 395),
                      width: _x(w, 175),
                      height: _y(h, 275),
                      child: _CurvedBirthWheel<int>(
                        controller: _yearController,
                        items: _years,
                        selectedIndex: _selectedYearIndex,
                        textBuilder: (value) => value.toString(),
                        curveType: _WheelCurveType.right,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedYearIndex = index;
                          });
                        },
                        s: _s(context, 1),
                      ),
                    ),
                  ],
                ),
              ),

              /// Privacy text
              Positioned(
                left: _x(w, 42),
                right: _x(w, 42),
                bottom: botPad + _y(h, 165),
                child: Column(
                  children: [
                    Text(
                      'We use this to generate your astrological birth chart.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceMono(
                        fontSize: _s(context, 20.5),
                        height: 1.42,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                        letterSpacing: _s(context, -0.25),
                      ),
                    ),
                    SizedBox(height: _y(h, 18)),
                    Text(
                      'We never share or sell your data.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceMono(
                        fontSize: _s(context, 20.5),
                        height: 1.42,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                        letterSpacing: _s(context, -0.25),
                      ),
                    ),
                  ],
                ),
              ),

              /// Continue button
              Positioned(
                left: _x(w, 47),
                right: _x(w, 47),
                bottom: botPad + _y(h, 38),
                child: _ContinueButton(
                  s: _s(context, 1),
                  onTap: () {
                    final day = _days[_selectedDayIndex];
                    final month = _months[_selectedMonthIndex];
                    final year = _years[_selectedYearIndex];

                    debugPrint('Selected birth date: $day $month $year');

                    /// Next screen will come here later.
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerLabel extends StatelessWidget {
  const _PickerLabel({
    required this.text,
    required this.s,
  });

  final String text;
  final double s;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16 * s,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF8D8D8D),
        letterSpacing: 0.5 * s,
      ),
    );
  }
}

enum _WheelCurveType {
  left,
  middle,
  right,
}

class _CurvedBirthWheel<T> extends StatelessWidget {
  const _CurvedBirthWheel({
    required this.controller,
    required this.items,
    required this.selectedIndex,
    required this.textBuilder,
    required this.curveType,
    required this.onSelectedItemChanged,
    required this.s,
  });

  final FixedExtentScrollController controller;
  final List<T> items;
  final int selectedIndex;
  final String Function(T value) textBuilder;
  final _WheelCurveType curveType;
  final ValueChanged<int> onSelectedItemChanged;
  final double s;

  double _curveXOffset(int distance) {
    final d = distance.toDouble();

    switch (curveType) {
      case _WheelCurveType.left:
        /// Day text sits between the first two grey curves.
        /// Top and bottom items move slightly left, like the reference.
        return -10.0 * d.abs() * s;

      case _WheelCurveType.middle:
        /// Month column is almost centered, only a soft curve.
        if (distance < 0) return -5.0 * s;
        if (distance > 0) return -4.0 * s;
        return 0;

      case _WheelCurveType.right:
        /// Year text follows the warm/red right curve.
        return 8.0 * d.abs() * s;
    }
  }

  double _curveRotation(int distance) {
    if (distance == 0) return 0;

    switch (curveType) {
      case _WheelCurveType.left:
        return distance < 0 ? -0.020 : 0.018;

      case _WheelCurveType.middle:
        return distance < 0 ? -0.010 : 0.010;

      case _WheelCurveType.right:
        return distance < 0 ? 0.018 : -0.018;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 76 * s,
      diameterRatio: 1.55,
      perspective: 0.0024,
      physics: const FixedExtentScrollPhysics(),
      overAndUnderCenterOpacity: 1.0,
      squeeze: 1.0,
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: items.length,
        builder: (context, index) {
          final distance = index - selectedIndex;
          final isSelected = distance == 0;

          final safeDistance = distance.clamp(-2, 2);
          final xOffset = _curveXOffset(safeDistance);
          final rotation = _curveRotation(safeDistance);

          final Color textColor = isSelected
              ? const Color(0xFF262626)
              : const Color(0xFFC9C9C9);

          final double fontSize = isSelected ? 29 * s : 28 * s;
          final double opacity = isSelected ? 1.0 : 0.78;

          return Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 160),
              opacity: opacity,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                offset: Offset(xOffset / 100, 0),
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  turns: rotation / (2 * math.pi),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    style: GoogleFonts.spaceMono(
                      fontSize: fontSize,
                      height: 1.0,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                      letterSpacing: isSelected ? 1.25 * s : 0.8 * s,
                    ),
                    child: Text(
                      textBuilder(items[index]),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.s,
    required this.onTap,
  });

  final double s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104 * s,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.zero,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 22 * s,
                  offset: Offset(0, 10 * s),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'CONTINUE',
                style: GoogleFonts.spaceMono(
                  fontSize: 24 * s,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 1.3 * s,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CurvedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final greyPaint = Paint()
      ..color = const Color(0xFFB9B9B9).withOpacity(0.56)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final softGreyPaint = Paint()
      ..color = const Color(0xFFD0D0D0).withOpacity(0.52)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final warmPaint = Paint()
      ..color = const Color(0xFFE4A29E).withOpacity(0.52)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    /// Left outer grey curve
    final Path line1 = Path()
      ..moveTo(size.width * 0.255, size.height * 0.045)
      ..cubicTo(
        size.width * 0.270,
        size.height * 0.220,
        size.width * 0.055,
        size.height * 0.390,
        size.width * 0.105,
        size.height * 0.560,
      )
      ..cubicTo(
        size.width * 0.145,
        size.height * 0.700,
        size.width * 0.248,
        size.height * 0.845,
        size.width * 0.255,
        size.height * 0.965,
      );

    /// Left inner grey curve
    final Path line2 = Path()
      ..moveTo(size.width * 0.385, size.height * 0.045)
      ..cubicTo(
        size.width * 0.370,
        size.height * 0.230,
        size.width * 0.300,
        size.height * 0.400,
        size.width * 0.310,
        size.height * 0.565,
      )
      ..cubicTo(
        size.width * 0.325,
        size.height * 0.735,
        size.width * 0.370,
        size.height * 0.875,
        size.width * 0.385,
        size.height * 0.965,
      );

    /// Right inner warm curve
    final Path line3 = Path()
      ..moveTo(size.width * 0.640, size.height * 0.045)
      ..cubicTo(
        size.width * 0.600,
        size.height * 0.260,
        size.width * 0.615,
        size.height * 0.430,
        size.width * 0.640,
        size.height * 0.585,
      )
      ..cubicTo(
        size.width * 0.675,
        size.height * 0.760,
        size.width * 0.605,
        size.height * 0.880,
        size.width * 0.640,
        size.height * 0.965,
      );

    /// Right outer warm curve
    final Path line4 = Path()
      ..moveTo(size.width * 0.825, size.height * 0.060)
      ..cubicTo(
        size.width * 0.760,
        size.height * 0.245,
        size.width * 0.905,
        size.height * 0.410,
        size.width * 0.888,
        size.height * 0.575,
      )
      ..cubicTo(
        size.width * 0.870,
        size.height * 0.730,
        size.width * 0.780,
        size.height * 0.875,
        size.width * 0.825,
        size.height * 0.965,
      );

    canvas.drawPath(line1, greyPaint);
    canvas.drawPath(line2, softGreyPaint);
    canvas.drawPath(line3, warmPaint);
    canvas.drawPath(line4, warmPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}