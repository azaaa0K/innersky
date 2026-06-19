import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_typography.dart';
import '../../core/onboarding_profile.dart';
import '../../shared/widgets/app_primary_button.dart';
import '../../shared/widgets/onboarding_close_button.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';

import 'package:innersky/Animation/loading_screen.dart';

class ClaimUsernameScreen extends StatefulWidget {
  const ClaimUsernameScreen({required this.profile, super.key});

  final OnboardingProfile profile;

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
      _usernameFocusNode.requestFocus();
      return;
    }

    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            LoadingScreen(profile: widget.profile.copyWith(username: username)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;
    final s = _s(context, 1);

    final topPad = MediaQuery.paddingOf(context).top;
    final botPad = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundPrimary,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(bottom: bottomInset),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(color: AppColors.backgroundPrimary),

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
                                Colors.white.withValues(alpha: 0.96),
                                Colors.white.withValues(alpha: 0.88),
                                Colors.white.withValues(alpha: 0.58),
                                Colors.white.withValues(alpha: 0.93),
                              ],
                              stops: const [0.0, 0.36, 0.70, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // ── Social header ────────────────────────────────────
                      Positioned(
                        left: _x(w, 55),
                        top: topPad + _y(h, 38),
                        child: Text(
                          'Posting to social?\nTag us, we\'re @innersky',
                          style: AppTypography.socialHeader(s),
                        ),
                      ),

                      // ── Close button (consistent circle style) ───────────
                      Positioned(
                        right: _x(w, 48),
                        top: topPad + _y(h, 34),
                        child: OnboardingCloseButton(
                          scale: s,
                          onTap: () => Navigator.of(context).maybePop(),
                        ),
                      ),

                      // ── Decorative moon icon ─────────────────────────────
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

                      // ── Decorative stars ─────────────────────────────────
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

                      // ── Step label + title + subtitle ─────────────────────
                      Positioned(
                        left: _x(w, 35),
                        right: _x(w, 35),
                        top: topPad + _y(h, 372),
                        child: Column(
                          children: [
                            Text(
                              'STEP  5  OF  5',
                              textAlign: TextAlign.center,
                              style: AppTypography.stepLabel(s),
                            ),
                            SizedBox(height: _y(h, 29)),
                            Text(
                              'CLAIM A USERNAME',
                              textAlign: TextAlign.center,
                              style: AppTypography.screenTitle(s),
                            ),
                            SizedBox(height: _y(h, 25)),
                            Text(
                              'Choose a unique handle for your profile.',
                              textAlign: TextAlign.center,
                              style: AppTypography.subtitle(s),
                            ),
                          ],
                        ),
                      ),

                      // ── Username input ───────────────────────────────────
                      Positioned(
                        left: _x(w, 122),
                        right: _x(w, 122),
                        top: topPad + _y(h, 680),
                        child: _UsernameInput(
                          controller: _usernameController,
                          focusNode: _usernameFocusNode,
                          scale: s,
                          onSubmitted: _continue,
                        ),
                      ),

                      // ── Cosmic background glow ────────────────────────────
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

                      // ── Helper text ───────────────────────────────────────
                      Positioned(
                        left: _x(w, 75),
                        right: _x(w, 75),
                        bottom: botPad + _y(h, 245),
                        child: Text(
                          'Letters, numbers, and underscores only.',
                          textAlign: TextAlign.center,
                          style: AppTypography.helperText(s),
                        ),
                      ),

                      // ── CTA button ─────────────────────────────────────────
                      Positioned(
                        left: _x(w, AppSizes.ctaHorizontalInset),
                        right: _x(w, AppSizes.ctaHorizontalInset),
                        bottom: botPad + _y(h, AppSizes.ctaBottomInset),
                        child: AppPrimaryButton(
                          label: 'CONTINUE',
                          scale: s,
                          isEnabled: _hasUsername,
                          onPressed: _continue,
                        ),
                      ),

                      // ── Progress indicator (fixed: all prior steps filled) ─
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: botPad + _y(h, AppSizes.progressBottomInset),
                        child: OnboardingProgressIndicator(
                          currentStep: 5,
                          totalSteps: 5,
                          scale: s,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Private widgets ──────────────────────────────────────────────────────────

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    required this.controller,
    required this.focusNode,
    required this.scale,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final double scale;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '@',
          textAlign: TextAlign.center,
          style: AppTypography.inputText(scale).copyWith(
            fontSize: 74 * scale,
            height: 0.95,
            letterSpacing: -1.0 * scale,
          ),
        ),
        SizedBox(height: 18 * scale),
        TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.black,
          cursorWidth: 1.3 * scale,
          cursorHeight: 48 * scale,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
            LengthLimitingTextInputFormatter(20),
          ],
          onSubmitted: (_) => onSubmitted(),
          style: AppTypography.inputText(scale),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: 'username',
            hintStyle: AppTypography.inputHint(scale),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: 24 * scale),
        Container(
          height: 1.1 * scale,
          width: double.infinity,
          color: AppColors.inputUnderline,
        ),
      ],
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
