import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_sizes.dart';

/// Shared circular close button used on onboarding screens.
///
/// Design values (from inventory):
///   Visible icon : 28 × scale  (midpoint of 27–30 found in username + time)
///   Container    : 66 × scale  (from claim_username; enforces ≥48 touch target)
///   Shape        : circle with white fill and drop shadow
///
/// enter_birth_date's original plain-SVG close button is replaced by this
/// consistent circle button.
/// enter_name intentionally has no close button (first step).
class OnboardingCloseButton extends StatelessWidget {
  const OnboardingCloseButton({
    required this.onTap,
    required this.scale,
    super.key,
  });

  /// Called when the user taps the button.
  final VoidCallback onTap;

  /// Scale factor from the screen's `_s(context, 1)` helper.
  final double scale;

  static const _assetBase = 'assets/welcome';

  @override
  Widget build(BuildContext context) {
    final containerSize = math.max(
      AppSizes.touchTarget,
      AppSizes.closeContainerSize * scale,
    );
    final iconSize = math.max(18.0, AppSizes.closeIconVisible * scale);

    return Tooltip(
      message: 'Close',
      child: Semantics(
        button: true,
        label: 'Close onboarding',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: math.max(14, 24 * scale),
                    offset: Offset(0, math.max(5, 10 * scale)),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  '$_assetBase/close.svg',
                  width: iconSize,
                  height: iconSize,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
