import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';

/// Shared onboarding step progress indicator.
///
/// Design values (from inventory):
///   Width   : 64 × scale  (from enter_name — the editorial reference screen)
///   Height  : 8 × scale   (from enter_name)
///   Gap     : 12 × scale  (half of the 25px gap in enter_name; symmetric)
///   Active  : #111111  (consistent: all prior steps + current step filled)
///   Inactive: #D9D9D9  (dominant: enter_name + enter_birth_time)
///   Radius  : pill (999)
///
/// Active logic: steps 1..currentStep are filled, steps currentStep+1..total are empty.
/// This differs from claim_username's original "only current step active" logic —
/// the name/time/location screens all use the fill-prior approach, which is correct.
///
/// Total steps: 5 (Name → Date → Time → Location → Username).
class OnboardingProgressIndicator extends StatelessWidget {
  const OnboardingProgressIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.scale,
    super.key,
  });

  /// 1-based index of the current step.
  final int currentStep;

  /// Total number of steps in the flow.
  final int totalSteps;

  /// Scale factor from the screen's `_s(context, 1)` helper.
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Step $currentStep of $totalSteps',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          final isActive = index < currentStep;

          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: math.max(AppSizes.progressBarHalfGap * scale, 6.0),
            ),
            width: math.max(AppSizes.progressBarWidth * scale, 34.0),
            height: math.max(AppSizes.progressBarHeight * scale, 5.0),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.progressActive
                  : AppColors.progressInactive,
              borderRadius: BorderRadius.circular(999),
            ),
          );
        }),
      ),
    );
  }
}
