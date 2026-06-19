import 'dart:math' as math;
import 'enter_name_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/onboarding_profile.dart';

const _kCardBg = Color(0xEBFFFFFF);
const _kShadow1 = Color(0x1A000000);
const _kShadow2 = Color(0x0A000000);
const _kBorderColor = Color(0x09000000);
const _kBtnShadow = Color(0x33000000);
const _kBadgeShadow = Color(0x21000000);
const _kGradWhite0 = Color(0xE6FFFFFF);
const _kGradWhite1 = Color(0xADFFFFFF);
const _kGradWhite2 = Color(0x26FFFFFF);
const _kFadeWhite0 = Color(0x00FFFFFF);
const _kFadeWhite1 = Color(0xB8FFFFFF);
const _kFadeWhite2 = Color(0xF5FFFFFF);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const String _assetBase = 'assets/welcome';

  double _x(double screenWidth, double value) => screenWidth * (value / 941);
  double _y(double screenHeight, double value) => screenHeight * (value / 1672);

  double _s(BuildContext context, double value) {
    final size = MediaQuery.sizeOf(context);
    final scale = math.min(size.width / 941, size.height / 1672);
    return value * scale;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;
    final topPad = MediaQuery.paddingOf(context).top;
    final botPad = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFB),
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.33,
                child: Image.asset(
                  '$_assetBase/cosmic.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            const Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.08),
                      radius: 0.82,
                      colors: [_kGradWhite0, _kGradWhite1, _kGradWhite2],
                      stops: [0.0, 0.48, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: _x(w, -30),
              top: _y(h, 205),
              child: Image.asset(
                '$_assetBase/planet_left.webp',
                width: _x(w, 340),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: _x(w, -90),
              top: _y(h, 330),
              child: Image.asset(
                '$_assetBase/planet_right-1.webp',
                width: _x(w, 295),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: _x(w, 224),
              top: _y(h, 245),
              child: _SmallStar(size: _s(context, 44)),
            ),
            Positioned(
              right: _x(w, 232),
              top: _y(h, 265),
              child: _SmallStar(size: _s(context, 35)),
            ),
            Positioned(
              right: _x(w, 194),
              top: _y(h, 517),
              child: _SmallStar(size: _s(context, 50)),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: _y(h, 292),
              child: Column(
                children: [
                  Text(
                    'InnerSky',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: _s(context, 92),
                      height: 0.98,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -4.5,
                    ),
                  ),
                  SizedBox(height: _y(h, 28)),
                  Text(
                    'THE PERSONAL ASTROLOGY APP',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: _s(context, 18),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF111111),
                      letterSpacing: 7.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: _x(w, 180),
              right: _x(w, 180),
              top: _y(h, 575),
              child: _HumanCard(assetBase: _assetBase, s: _s(context, 1)),
            ),
            Positioned(
              left: _x(w, 55),
              right: _x(w, 55),
              bottom: _y(h, 120),
              child: IgnorePointer(
                child: Image.asset(
                  '$_assetBase/bottom_moon-3.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _y(h, 245),
              height: _y(h, 210),
              child: const IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_kFadeWhite0, _kFadeWhite1, _kFadeWhite2],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: _x(w, 72),
              right: _x(w, 72),
              bottom: _y(h, 197) + botPad,
              child: _GetStartedButton(
                assetBase: _assetBase,
                s: _s(context, 1),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          const EnterNameScreen(profile: OnboardingProfile()),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _y(h, 105) + botPad,
              child: Center(
                child: Semantics(
                  button: true,
                  label: 'I already have an account',
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Account sign-in is not available yet.',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'I ALREADY HAVE AN ACCOUNT',
                      style: GoogleFonts.inter(
                        fontSize: _s(context, 20),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 2.9,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.2,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: math.max(_y(h, 37), botPad + 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    '$_assetBase/lock.svg',
                    width: _s(context, 25),
                    height: _s(context, 25),
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: _x(w, 18)),
                  Text(
                    'Your data is private and never shared.',
                    style: GoogleFonts.inter(
                      fontSize: _s(context, 17),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF191919),
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: _x(w, 45),
              top: topPad + _y(h, 20),
              child: Text(
                'Posting to social?\nTag us, we are @innersky',
                style: GoogleFonts.inter(
                  fontSize: _s(context, 23),
                  height: 1.22,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF070707),
                  letterSpacing: -0.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HumanCard extends StatelessWidget {
  const _HumanCard({required this.assetBase, required this.s});

  final String assetBase;
  final double s;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(42 * s, 72 * s, 42 * s, 42 * s),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(22 * s),
            border: Border.all(color: _kBorderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: _kShadow1,
                blurRadius: 32 * s,
                offset: Offset(0, 15 * s),
              ),
              BoxShadow(
                color: _kShadow2,
                blurRadius: 3 * s,
                offset: Offset(0, 1 * s),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'YOU ARE A HUMAN',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 25 * s,
                  height: 1.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  letterSpacing: 5.5,
                ),
              ),
              SizedBox(height: 23 * s),
              Text(
                'Stop lying to yourself.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 22 * s,
                  height: 1.1,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: -0.25,
                ),
              ),
              SizedBox(height: 36 * s),
              _CardRow(
                iconPath: '$assetBase/feather.svg',
                text: 'In journalism',
                s: s,
              ),
              SizedBox(height: 31 * s),
              _CardRow(
                iconPath: '$assetBase/moon.svg',
                text: 'Earth Moon',
                s: s,
              ),
              SizedBox(height: 31 * s),
              _CardRow(
                iconPath: '$assetBase/orbit.svg',
                text: 'Bad choices',
                s: s,
              ),
            ],
          ),
        ),
        Positioned(
          top: -42 * s,
          child: Container(
            width: 86 * s,
            height: 86 * s,
            padding: EdgeInsets.all(6 * s),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.5 * s),
              boxShadow: [
                BoxShadow(
                  color: _kBadgeShadow,
                  blurRadius: 14 * s,
                  offset: Offset(0, 6 * s),
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF191919),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  '$assetBase/black_star.svg',
                  width: 39 * s,
                  height: 39 * s,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardRow extends StatelessWidget {
  const _CardRow({required this.iconPath, required this.text, required this.s});

  final String iconPath;
  final String text;
  final double s;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: math.max(27 * s, 14)),
        SizedBox(
          width: 45 * s,
          height: 45 * s,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 42 * s,
              height: 42 * s,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: math.max(49 * s, 20)),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 22 * s,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              letterSpacing: -0.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({
    required this.assetBase,
    required this.s,
    required this.onTap,
  });

  final String assetBase;
  final double s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final height = math.max(109 * s, 52.0);

    return Semantics(
      button: true,
      label: 'Get started',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(math.max(24 * s, 14)),
            boxShadow: [
              BoxShadow(
                color: _kBtnShadow,
                blurRadius: 24 * s,
                offset: Offset(0, 9 * s),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: math.max(24 * s, 12)),
                Text(
                  'GET STARTED',
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
    );
  }
}

class _SmallStar extends StatelessWidget {
  const _SmallStar({required this.size});

  final double size;
  static const String _assetBase = 'assets/welcome';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      '$_assetBase/black_star.svg',
      width: size,
      height: size,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
    );
  }
}
