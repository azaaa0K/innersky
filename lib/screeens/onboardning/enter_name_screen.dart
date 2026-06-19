import 'dart:math' as math;
import 'enter_birth_date_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_typography.dart';
import '../../core/onboarding_profile.dart';
import '../../shared/widgets/app_primary_button.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({required this.profile, super.key});

  final OnboardingProfile profile;

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  static const String _assetBase = 'assets/welcome';

  bool get _hasName => _nameController.text.trim().isNotEmpty;

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

    _nameController.addListener(() {
      setState(() {});
    });

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
    final s = _s(context, 1);

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
                                Colors.white.withValues(alpha: 0.94),
                                Colors.white.withValues(alpha: 0.80),
                                Colors.white.withValues(alpha: 0.50),
                                Colors.white.withValues(alpha: 0.86),
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

                      // ── Social header ──────────────────────────────────────
                      Positioned(
                        left: _x(w, 55),
                        top: _y(h, 65),
                        child: SafeArea(
                          child: Text(
                            'Posting to social?\nTag us, we\'re @innersky',
                            style: AppTypography.socialHeader(s),
                          ),
                        ),
                      ),

                      // ── Decorative moon icon ───────────────────────────────
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

                      // ── Decorative stars ───────────────────────────────────
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

                      // ── Step label + title + subtitle ──────────────────────
                      Positioned(
                        left: _x(w, 35),
                        right: _x(w, 35),
                        top: _y(h, 372),
                        child: Column(
                          children: [
                            // Fixed: "STEP  1  OF  5" (flow is 5 steps total)
                            Text(
                              'STEP  1  OF  5',
                              textAlign: TextAlign.center,
                              style: AppTypography.stepLabel(s),
                            ),
                            SizedBox(height: _y(h, 29)),
                            Text(
                              'WHAT\'S YOUR NAME?',
                              textAlign: TextAlign.center,
                              style: AppTypography.screenTitle(s),
                            ),
                            SizedBox(height: _y(h, 25)),
                            Text(
                              'This helps personalize your chart and daily readings.',
                              textAlign: TextAlign.center,
                              style: AppTypography.subtitle(s),
                            ),
                          ],
                        ),
                      ),

                      // ── Name input ─────────────────────────────────────────
                      Positioned(
                        left: _x(w, 142),
                        right: _x(w, 142),
                        top: _y(h, 705),
                        child: _NameInput(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          scale: s,
                        ),
                      ),

                      // ── Helper / privacy copy ──────────────────────────────
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
                                    style: AppTypography.helperText(s),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: _y(h, 20)),
                            Text(
                              'We never share or sell your data.',
                              textAlign: TextAlign.center,
                              style: AppTypography.helperText(s),
                            ),
                          ],
                        ),
                      ),

                      // ── CTA button ─────────────────────────────────────────
                      Positioned(
                        left: _x(w, AppSizes.ctaHorizontalInset),
                        right: _x(w, AppSizes.ctaHorizontalInset),
                        bottom: _y(h, AppSizes.ctaBottomInset),
                        child: AppPrimaryButton(
                          label: 'CONTINUE',
                          scale: s,
                          isEnabled: _hasName,
                          onPressed: () {
                            if (!_hasName) {
                              _nameFocusNode.requestFocus();
                              return;
                            }
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EnterBirthDateScreen(
                                  profile: widget.profile.copyWith(
                                    name: _nameController.text.trim(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // ── Progress indicator ─────────────────────────────────
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: _y(h, AppSizes.progressBottomInset),
                        child: OnboardingProgressIndicator(
                          currentStep: 1,
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
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            cursorWidth: 1.4 * scale,
            cursorHeight: 70 * scale,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [LengthLimitingTextInputFormatter(22)],
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                FocusScope.of(context).unfocus();
              }
            },
            // Name field keeps its original larger size (58) for editorial impact
            style: AppTypography.inputText(
              scale,
            ).copyWith(fontSize: 58 * scale, letterSpacing: -1.0 * scale),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'your name',
              hintStyle: AppTypography.inputHint(
                scale,
              ).copyWith(fontSize: 48 * scale, letterSpacing: -1.0 * scale),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        SizedBox(height: 20 * scale),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1.1 * scale,
                color: AppColors.inputUnderline,
              ),
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
              child: Container(
                height: 1.1 * scale,
                color: AppColors.inputUnderline,
              ),
            ),
          ],
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
