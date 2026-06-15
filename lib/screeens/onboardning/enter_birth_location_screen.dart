import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innersky/Animation/loading_screen.dart';

class EnterBirthLocationScreen extends StatefulWidget {
  const EnterBirthLocationScreen({super.key});

  @override
  State<EnterBirthLocationScreen> createState() =>
      _EnterBirthLocationScreenState();
}

class _EnterBirthLocationScreenState extends State<EnterBirthLocationScreen> {
  static const String _assetBase = 'assets/welcome';

  final TextEditingController _cityController = TextEditingController();
  final FocusNode _cityFocusNode = FocusNode();

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

  bool get _hasCity => _cityController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _cityController.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _cityFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _cityFocusNode.dispose();
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
        backgroundColor: const Color(0xFFF7F7F6),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox.expand(
            child: Stack(
              children: [
                Container(color: const Color(0xFFF7F7F6)),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.12),
                        radius: 1.08,
                        colors: [
                          Colors.white.withOpacity(0.95),
                          const Color(0xFFF7F7F6).withOpacity(0.92),
                          const Color(0xFFF3F3F2).withOpacity(0.96),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: _x(w, 58),
                  top: topPad + _y(h, 42),
                  child: Text(
                    'Posting to social?\nTag us, we\'re @costarastrology!',
                    style: GoogleFonts.spaceMono(
                      fontSize: _s(context, 23),
                      height: 1.42,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: _s(context, 0.15),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: topPad + _y(h, 235),
                  child: Text(
                    'WHERE WERE YOU BORN?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceMono(
                      fontSize: _s(context, 23),
                      height: 1.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5C5C5C),
                      letterSpacing: _s(context, 2.0),
                    ),
                  ),
                ),
                Positioned(
                  left: _x(w, 122),
                  right: _x(w, 122),
                  top: topPad + _y(h, 392),
                  child: Column(
                    children: [
                      TextField(
                        controller: _cityController,
                        focusNode: _cityFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        cursorColor: Colors.black,
                        cursorWidth: 1.2 * _s(context, 1),
                        cursorHeight: 42 * _s(context, 1),
                        style: GoogleFonts.playfairDisplay(
                          fontSize: _s(context, 42),
                          height: 1.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: _s(context, -0.5),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'city',
                          hintStyle: GoogleFonts.playfairDisplay(
                            fontSize: _s(context, 42),
                            height: 1.05,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9E9E9E),
                            letterSpacing: _s(context, -0.5),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(height: _y(h, 30)),
                      Container(
                        height: 1.2 * _s(context, 1),
                        width: double.infinity,
                        color: const Color(0xFF8C8C8C),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: _x(w, 75),
                  right: _x(w, 75),
                  bottom: botPad + _y(h, 214),
                  child: Text(
                    'We use this to generate your astrological birth\nchart. We never share or sell your data.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceMono(
                      fontSize: _s(context, 22),
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF555555),
                      letterSpacing: _s(context, -0.3),
                    ),
                  ),
                ),
                Positioned(
                  left: _x(w, 86),
                  right: _x(w, 86),
                  bottom: botPad + _y(h, 96),
                  child: _ContinueButton(
                    s: _s(context, 1),
                    onTap: () {
                      final city = _cityController.text.trim();

                      if (city.isEmpty) {
                        return;
                      }

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LoadingScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: botPad + _y(h, 38),
                  child: _StepProgressIndicator(
                    currentStep: 4,
                    totalSteps: 4,
                    s: _s(context, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.s, required this.onTap});

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
        SizedBox(height: 16 * s),
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
