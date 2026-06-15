import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'enter_birth_location_screen.dart';

class EnterBirthTimeScreen extends StatefulWidget {
  const EnterBirthTimeScreen({super.key});

  @override
  State<EnterBirthTimeScreen> createState() => _EnterBirthTimeScreenState();
}

class _EnterBirthTimeScreenState extends State<EnterBirthTimeScreen> {
  static const String _assetBase = 'assets/welcome';

  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<String> _minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));
  final List<String> _periods = const ['AM', 'PM'];

  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _periodController;

  int _selectedHourIndex = 9;
  int _selectedMinuteIndex = 30;
  int _selectedPeriodIndex = 0;

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

    _hourController = FixedExtentScrollController(
      initialItem: _selectedHourIndex,
    );

    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinuteIndex,
    );

    _periodController = FixedExtentScrollController(
      initialItem: _selectedPeriodIndex,
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
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
              Positioned(
                left: _x(w, 56),
                top: topPad + _y(h, 42),
                child: Text(
                  'Posting to social?\nTag us, we\'re @costarastrology!',
                  style: GoogleFonts.spaceMono(
                    fontSize: _s(context, 23),
                    height: 1.42,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: _s(context, 0.2),
                  ),
                ),
              ),
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
              Positioned(
                left: 0,
                right: 0,
                top: topPad + _y(h, 230),
                child: Text(
                  'WHAT\'S YOUR BIRTH TIME?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceMono(
                    fontSize: _s(context, 23),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4B4B4B),
                    letterSpacing: _s(context, 2.2),
                  ),
                ),
              ),
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
                    Positioned(
                      left: _x(w, 122),
                      top: _y(h, 338),
                      child: _PickerLabel(
                        text: 'HOUR',
                        s: _s(context, 1),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 10,
                      top: _y(h, 338),
                      child: Center(
                        child: _PickerLabel(
                          text: 'MINUTE',
                          s: _s(context, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      right: _x(w, 130),
                      top: _y(h, 338),
                      child: _PickerLabel(
                        text: 'AM/PM',
                        s: _s(context, 1),
                      ),
                    ),
                    Positioned(
                      left: _x(w, 70),
                      top: _y(h, 395),
                      width: _x(w, 130),
                      height: _y(h, 275),
                      child: _CurvedWheel<int>(
                        controller: _hourController,
                        items: _hours,
                        selectedIndex: _selectedHourIndex,
                        textBuilder: (value) => value.toString(),
                        curveType: _WheelCurveType.left,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedHourIndex = index;
                          });
                        },
                        s: _s(context, 1),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _y(h, 395),
                      height: _y(h, 275),
                      child: Center(
                        child: SizedBox(
                          width: _x(w, 220),
                          child: _CurvedWheel<String>(
                            controller: _minuteController,
                            items: _minutes,
                            selectedIndex: _selectedMinuteIndex,
                            textBuilder: (value) => value,
                            curveType: _WheelCurveType.middle,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                _selectedMinuteIndex = index;
                              });
                            },
                            s: _s(context, 1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: _x(w, 78),
                      top: _y(h, 395),
                      width: _x(w, 155),
                      height: _y(h, 275),
                      child: _CurvedWheel<String>(
                        controller: _periodController,
                        items: _periods,
                        selectedIndex: _selectedPeriodIndex,
                        textBuilder: (value) => value,
                        curveType: _WheelCurveType.right,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedPeriodIndex = index;
                          });
                        },
                        s: _s(context, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: _x(w, 42),
                right: _x(w, 42),
                bottom: botPad + _y(h, 230),
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
              Positioned(
                left: _x(w, 55),
                right: _x(w, 55),
                bottom: botPad + _y(h, 86),
                child: _ContinueButton(
                  s: _s(context, 1),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const EnterBirthLocationScreen(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: botPad + _y(h, 36),
                child: _StepProgressIndicator(
                  currentStep: 3,
                  totalSteps: 4,
                  s: _s(context, 1),
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

class _CurvedWheel<T> extends StatelessWidget {
  const _CurvedWheel({
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

  TextAlign get _textAlign {
    switch (curveType) {
      case _WheelCurveType.left:
        return TextAlign.left;
      case _WheelCurveType.middle:
        return TextAlign.center;
      case _WheelCurveType.right:
        return TextAlign.right;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 58 * s,
      diameterRatio: 1.8,
      perspective: 0.006,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: items.length,
        builder: (context, index) {
          if (index < 0 || index >= items.length) {
            return null;
          }

          final bool isSelected = index == selectedIndex;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 120),
            opacity: isSelected ? 1.0 : 0.68,
            child: Align(
              alignment: curveType == _WheelCurveType.left
                  ? Alignment.centerLeft
                  : curveType == _WheelCurveType.right
                      ? Alignment.centerRight
                      : Alignment.center,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 120),
                style: GoogleFonts.spaceMono(
                  fontSize: isSelected ? 27 * s : 23 * s,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF262626)
                      : const Color(0xFFC9C9C9),
                  height: 1.0,
                ),
                child: Text(
                  textBuilder(items[index]),
                  textAlign: _textAlign,
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
          borderRadius: BorderRadius.circular(24 * s),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24 * s),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24 * s,
                  offset: Offset(0, 11 * s),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CONTINUE',
                    style: GoogleFonts.spaceMono(
                      fontSize: 24 * s,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 2.5 * s,
                    ),
                  ),
                  SizedBox(width: 44 * s),
                  Text(
                    '→',
                    style: GoogleFonts.spaceMono(
                      fontSize: 38 * s,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  const _StepProgressIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.s,
  });

  final int currentStep;
  final int totalSteps;
  final double s;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$currentStep / $totalSteps',
          style: GoogleFonts.spaceMono(
            fontSize: 18 * s,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            letterSpacing: 1.5 * s,
          ),
        ),
        SizedBox(height: 18 * s),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSteps, (index) {
            final isActive = index <= currentStep - 1;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 6 * s),
              width: 66 * s,
              height: 6 * s,
              decoration: BoxDecoration(
                color: isActive ? Colors.black : const Color(0xFFD6D6D6),
                borderRadius: BorderRadius.circular(100),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CurvedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint fadePaint(Color color, {double opacity = 0.55}) {
      return Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.0),
            color.withOpacity(opacity),
            color.withOpacity(opacity),
            color.withOpacity(0.0),
          ],
          stops: const [
            0.00,
            0.16,
            0.84,
            1.00,
          ],
        ).createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        )
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    }

    final greyPaint = fadePaint(
      const Color(0xFFB9B9B9),
      opacity: 0.56,
    );

    final softGreyPaint = fadePaint(
      const Color(0xFFD0D0D0),
      opacity: 0.52,
    );

    final warmPaint = fadePaint(
      const Color(0xFFE4A29E),
      opacity: 0.52,
    );

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

    final Path line2 = Path()
      ..moveTo(size.width * 0.320, size.height * 0.060)
      ..cubicTo(
        size.width * 0.330,
        size.height * 0.240,
        size.width * 0.185,
        size.height * 0.410,
        size.width * 0.215,
        size.height * 0.565,
      )
      ..cubicTo(
        size.width * 0.240,
        size.height * 0.715,
        size.width * 0.315,
        size.height * 0.855,
        size.width * 0.320,
        size.height * 0.960,
      );

    final Path line3 = Path()
      ..moveTo(size.width * 0.500, size.height * 0.050)
      ..cubicTo(
        size.width * 0.500,
        size.height * 0.230,
        size.width * 0.500,
        size.height * 0.405,
        size.width * 0.500,
        size.height * 0.565,
      )
      ..cubicTo(
        size.width * 0.500,
        size.height * 0.720,
        size.width * 0.500,
        size.height * 0.855,
        size.width * 0.500,
        size.height * 0.965,
      );

    final Path line4 = Path()
      ..moveTo(size.width * 0.680, size.height * 0.060)
      ..cubicTo(
        size.width * 0.670,
        size.height * 0.240,
        size.width * 0.815,
        size.height * 0.410,
        size.width * 0.785,
        size.height * 0.565,
      )
      ..cubicTo(
        size.width * 0.760,
        size.height * 0.715,
        size.width * 0.685,
        size.height * 0.855,
        size.width * 0.680,
        size.height * 0.960,
      );

    final Path line5 = Path()
      ..moveTo(size.width * 0.745, size.height * 0.045)
      ..cubicTo(
        size.width * 0.730,
        size.height * 0.220,
        size.width * 0.945,
        size.height * 0.390,
        size.width * 0.895,
        size.height * 0.560,
      )
      ..cubicTo(
        size.width * 0.855,
        size.height * 0.700,
        size.width * 0.752,
        size.height * 0.845,
        size.width * 0.745,
        size.height * 0.965,
      );

    canvas.drawPath(line1, greyPaint);
    canvas.drawPath(line2, softGreyPaint);
    canvas.drawPath(line3, warmPaint);
    canvas.drawPath(line4, softGreyPaint);
    canvas.drawPath(line5, greyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
