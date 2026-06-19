import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_typography.dart';
import '../../core/onboarding_profile.dart';
import '../../shared/widgets/app_primary_button.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';

import 'claim_username_screen.dart';

class EnterBirthLocationScreen extends StatefulWidget {
  const EnterBirthLocationScreen({required this.profile, super.key});

  final OnboardingProfile profile;

  @override
  State<EnterBirthLocationScreen> createState() =>
      _EnterBirthLocationScreenState();
}

class _EnterBirthLocationScreenState extends State<EnterBirthLocationScreen> {
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

  void _proceed() {
    if (!_hasCity) {
      _cityFocusNode.requestFocus();
      return;
    }
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClaimUsernameScreen(
          profile: widget.profile.copyWith(
            birthLocation: _cityController.text.trim(),
          ),
        ),
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
      // Note: backgroundSecondary (#F7F7F6) is preserved as an intentional
      // surface distinction for this step.
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundSecondary,
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
                    children: [
                      Container(color: AppColors.backgroundSecondary),

                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: const Alignment(0, -0.12),
                              radius: 1.08,
                              colors: [
                                Colors.white.withValues(alpha: 0.95),
                                AppColors.backgroundSecondary.withValues(
                                  alpha: 0.92,
                                ),
                                const Color(0xFFF3F3F2).withValues(alpha: 0.96),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ── Social header (fixed: @innersky) ──────────────────
                      Positioned(
                        left: _x(w, 58),
                        top: topPad + _y(h, 42),
                        child: Text(
                          'Posting to social?\nTag us, we\'re @innersky',
                          style: AppTypography.socialHeader(s),
                        ),
                      ),

                      // ── Step label + Title (aligned: Playfair) ─────────────
                      Positioned(
                        left: 0,
                        right: 0,
                        top: topPad + _y(h, 200),
                        child: Column(
                          children: [
                            Text(
                              'STEP  4  OF  5',
                              textAlign: TextAlign.center,
                              style: AppTypography.stepLabel(s),
                            ),
                            SizedBox(height: _y(h, 26)),
                            Text(
                              'WHERE WERE YOU BORN?',
                              textAlign: TextAlign.center,
                              style: AppTypography.screenTitle(s),
                            ),
                          ],
                        ),
                      ),

                      // ── City input ─────────────────────────────────────────
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
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              cursorColor: Colors.black,
                              cursorWidth: 1.2 * s,
                              cursorHeight: 42 * s,
                              onSubmitted: (_) => _proceed(),
                              style: AppTypography.inputText(s),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'city',
                                hintStyle: AppTypography.inputHint(s),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            SizedBox(height: _y(h, 30)),
                            Container(
                              height: 1.2 * s,
                              width: double.infinity,
                              color: AppColors.inputUnderline.withValues(
                                alpha: 0.55,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Privacy copy (fixed: was SpaceMono, now Inter) ─────
                      Positioned(
                        left: _x(w, 75),
                        right: _x(w, 75),
                        bottom: botPad + _y(h, 214),
                        child: Text(
                          'We use this to generate your astrological birth\nchart. We never share or sell your data.',
                          textAlign: TextAlign.center,
                          style: AppTypography.helperText(s),
                        ),
                      ),

                      // ── CTA button (aligned inset: 55 from edges) ──────────
                      Positioned(
                        left: _x(w, AppSizes.ctaHorizontalInset),
                        right: _x(w, AppSizes.ctaHorizontalInset),
                        bottom: botPad + _y(h, AppSizes.ctaBottomInset),
                        child: AppPrimaryButton(
                          label: 'CONTINUE',
                          scale: s,
                          isEnabled: _hasCity,
                          onPressed: _proceed,
                        ),
                      ),

                      // ── Progress indicator ─────────────────────────────────
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: botPad + _y(h, AppSizes.progressBottomInset),
                        child: OnboardingProgressIndicator(
                          currentStep: 4,
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
