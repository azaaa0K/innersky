import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_typography.dart';

/// The standard primary CTA button for all onboarding steps.
///
/// Design values (from inventory):
///   Height  : 104 × scale  (consistent across name, date, location, username, time)
///   Radius  : 24 × scale   (dominant: name, location, username)
///   Label   : Space Mono 24, letterSpacing 2.5 (consistent across all)
///   Arrow   : '→' Space Mono 38 w300 (dominant: name, location, username)
///   Gap     : 44 × scale   (from name, location, username)
///
/// The Welcome "Get Started" button is a deliberate landing-page variant
/// and is NOT represented by this class.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.scale = 1.0,
    this.isEnabled = true,
    this.showArrow = true,
    super.key,
  });

  /// Button label text (should be ALL-CAPS to match existing style).
  final String label;

  /// Called when the button is tapped. Pass [null] to force disabled state.
  final VoidCallback? onPressed;

  /// Scale factor from the screen's `_s(context, 1)` helper.
  final double scale;

  /// When [false] the button renders in disabled colour and is non-tappable.
  final bool isEnabled;

  /// Whether to show the → arrow glyph after the label.
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final height = math.max(AppSizes.primaryButtonHeight * scale, 52.0);
    final radius = math.max(AppSizes.primaryButtonRadius * scale, 14.0);
    final isActive = isEnabled && onPressed != null;

    return Semantics(
      button: true,
      label: label,
      enabled: isActive,
      child: SizedBox(
        height: height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: isActive ? onPressed : null,
            child: Ink(
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.buttonPrimary
                    : AppColors.buttonDisabled,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 24 * scale,
                          offset: Offset(0, 11 * scale),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: AppTypography.ctaLabel(scale)),
                    if (showArrow) ...[
                      SizedBox(
                        width: math.max(
                          AppSizes.primaryButtonArrowGap * scale,
                          20,
                        ),
                      ),
                      Text('→', style: AppTypography.ctaArrow(scale)),
                    ],
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
