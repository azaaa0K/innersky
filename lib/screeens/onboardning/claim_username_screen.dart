import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ClaimUsernameScreen extends StatefulWidget {
  const ClaimUsernameScreen({super.key});

  @override
  State<ClaimUsernameScreen> createState() => _ClaimUsernameScreenState();
}

class _ClaimUsernameScreenState extends State<ClaimUsernameScreen> {
  static const String _assetBase = 'assets/welcome';

  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();

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

  bool get _hasUsername => _usernameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _usernameFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  void _continue() {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      return;
    }

    debugPrint('Claimed username: @$username');

    /// Next screen goes here later.
    /// Navigator.of(context).pushReplacement(
    ///   MaterialPageRoute(
    ///     builder: (_) => const NextScreen(),
    ///   ),
    /// );
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox.expand(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(color: const Color(0xFFFCFCFB)),

                Positioned.fill(
                  child: Opacity(
                    opacity: 0.22,
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
                          Colors.white.withOpacity(0.96),
                          Colors.white.withOpacity(0.88),
                          Colors.white.withOpacity(0.58),
                          Colors.white.withOpacity(0.93),
                        ],
                        stops: const [0.0, 0.36, 0.70, 1.0],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: _x(w, 55),
                  top: topPad + _y(h, 38),
                  child: Text(
                    'Posting to social?\nTag us, we’re @innersky',
                    style: GoogleFonts.inter(
                      fontSize: _s(context, 21),
                      height: 1.52,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF050505),
                      letterSpacing: _s(context, 1.1),
                    ),
                  ),
                ),

                Positioned(
                  right: _x(w, 48),
                  top: topPad + _y(h, 34),
                  child: Container(
                    width: _s(context, 66),
                    height: _s(context, 66),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: _s(context, 24),
                          offset: Offset(0, _s(context, 10)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        '$_assetBase/close.svg',
                        width: _s(context, 27),
                        height: _s(context, 27),
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: topPad + _y(h, 205),
                  child: Center(
                    child: SizedBox(
                      width: _s(context, 82),
                      height: _s(context, 82),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            '$_assetBase/moon.svg',
                            width: _s(context, 70),
                            height: _s(context, 70),
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
                  top: topPad + _y(h, 308),
                  child: _SmallStar(size: _s(context, 18), opacity: 0.18),
                ),
                Positioned(
                  left: _x(w, 108),
                  top: topPad + _y(h, 355),
                  child: _SmallStar(size: _s(context, 21), opacity: 0.18),
                ),
                Positioned(
                  right: _x(w, 165),
                  top: topPad + _y(h, 303),
                  child: _SmallStar(size: _s(context, 22), opacity: 0.22),
                ),
                Positioned(
                  right: _x(w, 100),
                  top: topPad + _y(h, 370),
                  child: _SmallStar(size: _s(context, 26), opacity: 0.22),
                ),

                Positioned(
                  left: _x(w, 35),
                  right: _x(w, 35),
                  top: topPad + _y(h, 372),
                  child: Column(
                    children: [
                      Text(
                        'STEP  5  OF  5',
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
                        'CLAIM A USERNAME',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: _s(context, 37),
                          height: 1.06,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: _s(context, 3.3),
                        ),
                      ),
                      SizedBox(height: _y(h, 25)),
                      Text(
                        'Choose a unique handle for your profile.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: _s(context, 17.5),
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF626262),
                          letterSpacing: _s(context, 1.2),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: _x(w, 122),
                  right: _x(w, 122),
                  top: topPad + _y(h, 680),
                  child: _UsernameInput(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    scale: _s(context, 1),
                  ),
                ),

                Positioned(
                  left: _x(w, -120),
                  right: _x(w, -120),
                  top: _y(h, 890),
                  height: _y(h, 650),
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.45,
                      child: Image.asset(
                        '$_assetBase/cosmic.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: _x(w, 75),
                  right: _x(w, 75),
                  bottom: botPad + _y(h, 245),
                  child: Text(
                    'Letters, numbers, and underscores only.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: _s(context, 17),
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF525252),
                      letterSpacing: _s(context, 0.2),
                    ),
                  ),
                ),

                Positioned(
                  left: _x(w, 55),
                  right: _x(w, 55),
                  bottom: botPad + _y(h, 86),
                  child: _ContinueButton(
                    s: _s(context, 1),
                    enabled: _hasUsername,
                    onTap: _continue,
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: botPad + _y(h, 34),
                  child: _StepProgressIndicator(
                    currentStep: 5,
                    totalSteps: 5,
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

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    required this.controller,
    required this.focusNode,
    required this.scale,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '@',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 74 * scale,
            height: 0.95,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF111111),
            letterSpacing: -1.0 * scale,
          ),
        ),
        SizedBox(height: 18 * scale),
        TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          cursorColor: Colors.black,
          cursorWidth: 1.3 * scale,
          cursorHeight: 48 * scale,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
            LengthLimitingTextInputFormatter(20),
          ],
          style: GoogleFonts.playfairDisplay(
            fontSize: 46 * scale,
            height: 1.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.8 * scale,
          ),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: 'username',
            hintStyle: GoogleFonts.playfairDisplay(
              fontSize: 46 * scale,
              height: 1.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9A9A9A),
              letterSpacing: -0.8 * scale,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: 24 * scale),
        Container(
          height: 1.1 * scale,
          width: double.infinity,
          color: Colors.black,
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.s,
    required this.enabled,
    required this.onTap,
  });

  final double s;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104 * s,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24 * s),
          onTap: enabled ? onTap : null,
          child: Ink(
            decoration: BoxDecoration(
              color: enabled ? Colors.black : const Color(0xFFBDBDBD),
              borderRadius: BorderRadius.circular(24 * s),
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24 * s,
                        offset: Offset(0, 11 * s),
                      ),
                    ]
                  : null,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep - 1;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6 * s),
          width: 54 * s,
          height: 6 * s,
          decoration: BoxDecoration(
            color: isActive ? Colors.black : const Color(0xFFD6D6D6),
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}

class _SmallStar extends StatelessWidget {
  const _SmallStar({
    required this.size,
    required this.opacity,
  });

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
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}