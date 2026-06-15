import 'dart:math' as math;
import 'enter_birth_date_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  static const String _assetBase = 'assets/welcome';

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

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _nameFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFCFCFB),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox.expand(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(color: const Color(0xFFFCFCFB)),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.26,
                  child: Image.asset(
                    '$_assetBase/cosmic.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.94),
                        Colors.white.withOpacity(0.80),
                        Colors.white.withOpacity(0.50),
                        Colors.white.withOpacity(0.86),
                      ],
                      stops: const [0.0, 0.36, 0.68, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _x(w, -115),
                right: _x(w, -115),
                bottom: _y(h, 355),
                height: _y(h, 645),
                child: Opacity(
                  opacity: 0.52,
                  child: Image.asset(
                    '$_assetBase/cosmic.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                left: _x(w, 55),
                top: _y(h, 65),
                child: SafeArea(
                  child: Text(
                    'Posting to social?\nTag us, we\'re @innersky',
                    style: GoogleFonts.inter(
                      fontSize: _s(context, 21),
                      height: 1.52,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF050505),
                      letterSpacing: _s(context, 1.1),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: _y(h, 240),
                child: Center(
                  child: SizedBox(
                    width: _s(context, 82),
                    height: _s(context, 82),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          '$_assetBase/moon_with_stars.svg',
                          width: _s(context, 100),
                          height: _s(context, 100),
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        Positioned(
                          right: _s(context, 8),
                          top: _s(context, 22),
                          child: SvgPicture.asset(
                            '$_assetBase/black_star.svg',
                            width: _s(context, 25),
                            height: _s(context, 25),
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _x(w, 150),
                top: _y(h, 308),
                child: _SmallStar(size: _s(context, 34), opacity: 0.18),
              ),
              Positioned(
                left: _x(w, 108),
                top: _y(h, 355),
                child: _SmallStar(size: _s(context, 35), opacity: 0.18),
              ),
              Positioned(
                right: _x(w, 165),
                top: _y(h, 303),
                child: _SmallStar(size: _s(context, 31), opacity: 0.22),
              ),
              Positioned(
                right: _x(w, 100),
                top: _y(h, 370),
                child: _SmallStar(size: _s(context, 25), opacity: 0.22),
              ),
              Positioned(
                right: _x(w, 240),
                top: _y(h, 980),
                child: _SmallStar(size: _s(context, 23), opacity: 0.18),
              ),
              Positioned(
                left: _x(w, 78),
                top: _y(h, 1040),
                child: _SmallStar(size: _s(context, 24), opacity: 0.18),
              ),
              Positioned(
                left: _x(w, 198),
                top: _y(h, 1280),
                child: _SmallStar(size: _s(context, 23), opacity: 0.20),
              ),
              Positioned(
                left: _x(w, 35),
                right: _x(w, 35),
                top: _y(h, 372),
                child: Column(
                  children: [
                    Text(
                      'STEP  1  OF  4',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: _s(context, 17),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                        letterSpacing: _s(context, 8.0),
                      ),
                    ),
                    SizedBox(height: _y(h, 29)),
                    Text(
                      'WHAT\'S YOUR NAME?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: _s(context, 37),
                        height: 1.06,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: _s(context, 4.3),
                      ),
                    ),
                    SizedBox(height: _y(h, 25)),
                    Text(
                      'This helps personalize your chart and daily readings.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: _s(context, 17.5),
                        height: 1.35,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF626262),
                        letterSpacing: _s(context, 1.7),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: _x(w, 142),
                right: _x(w, 142),
                top: _y(h, 705),
                child: _NameInput(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  scale: _s(context, 1),
                ),
              ),
              Positioned(
                left: _x(w, 95),
                right: _x(w, 95),
                bottom: _y(h, 270),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: _x(w, 13)),
                        Flexible(
                          child: Text(
                            'We use this to generate your astrological birth chart.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: _s(context, 16.5),
                              height: 1.35,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF525252),
                              letterSpacing: _s(context, 0.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _y(h, 20)),
                    Text(
                      'We never share or sell your data.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: _s(context, 17),
                        height: 1.35,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF525252),
                        letterSpacing: _s(context, 0.2),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: _x(w, 55),
                right: _x(w, 55),
                bottom: _y(h, 98),
                child: _ContinueButton(
                  s: _s(context, 1),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const EnterBirthDateScreen(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: _y(h, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _IndicatorBar(active: true, scale: _s(context, 1)),
                    SizedBox(width: _x(w, 25)),
                    _IndicatorBar(active: false, scale: _s(context, 1)),
                    SizedBox(width: _x(w, 25)),
                    _IndicatorBar(active: false, scale: _s(context, 1)),
                    SizedBox(width: _x(w, 25)),
                    _IndicatorBar(active: false, scale: _s(context, 1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({
    required this.controller,
    required this.focusNode,
    required this.scale,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final double scale;

  static const String _assetBase = 'assets/welcome';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicWidth(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            cursorWidth: 1.4 * scale,
            cursorHeight: 70 * scale,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [LengthLimitingTextInputFormatter(22)],
            style: GoogleFonts.playfairDisplay(
              fontSize: 58 * scale,
              height: 1.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -1.0 * scale,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'your name',
              hintStyle: GoogleFonts.playfairDisplay(
                fontSize: 48 * scale,
                height: 1.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9A9A9A),
                letterSpacing: -1.0 * scale,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        SizedBox(height: 20 * scale),
        Row(
          children: [
            Expanded(
              child: Container(height: 1.1 * scale, color: Colors.black),
            ),
            SizedBox(width: 16 * scale),
            SvgPicture.asset(
              '$_assetBase/black_star.svg',
              width: 24 * scale,
              height: 24 * scale,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Container(height: 1.1 * scale, color: Colors.black),
            ),
          ],
        ),
      ],
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
  static const String _assetBase = 'assets/welcome';

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
      ),
    );
  }
}

class _IndicatorBar extends StatelessWidget {
  const _IndicatorBar({required this.active, required this.scale});

  final bool active;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64 * scale,
      height: 8 * scale,
      decoration: BoxDecoration(
        color: active ? Colors.black : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

class _SmallStar extends StatelessWidget {
  const _SmallStar({required this.size, required this.opacity});

  final double size;
  final double opacity;
  static const String _assetBase = 'assets/welcome';

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SvgPicture.asset(
        '$_assetBase/black_star.svg',
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
    );
  }
}
