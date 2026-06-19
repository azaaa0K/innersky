import 'package:flutter/material.dart';

/// Semantic color tokens for InnerSky.
///
/// Every value here was extracted from the existing screen files.
/// No new colors have been introduced.
abstract final class AppColors {
  // ── Backgrounds ────────────────────────────────────────────────────────────

  /// Used on welcome, name, time, username, loading, and home screens.
  /// Source: dominant across 4/5 onboarding screens.
  static const backgroundPrimary = Color(0xFFFCFCFB);

  /// Used on birth-location screen only.
  /// Preserved as an intentional surface variant for that step.
  static const backgroundSecondary = Color(0xFFF7F7F6);

  // ── Text ───────────────────────────────────────────────────────────────────

  /// Primary foreground. Used for all headings and input text.
  static const textPrimary = Color(0xFF111111);

  /// Secondary body copy, privacy notices, subtitles.
  /// Source: #525252 used in name + time screens (most common).
  static const textSecondary = Color(0xFF525252);

  /// Muted — step labels ("STEP X OF 5") and less prominent labels.
  /// Source: #777777 used in name + username screens.
  static const textMuted = Color(0xFF777777);

  /// Input hint text.
  /// Source: #9A9A9A used in name + username (largest-font input screens).
  static const textHint = Color(0xFF9A9A9A);

  // ── Progress ───────────────────────────────────────────────────────────────

  /// Filled/active progress bar segment.
  /// Source: consistent across all screens (Colors.black / #111111).
  static const progressActive = Color(0xFF111111);

  /// Empty/inactive progress bar segment.
  /// Source: #D9D9D9 used in name + time screens (dominant).
  /// (#D6D6D6 in location + username was near-duplicate; unified here.)
  static const progressInactive = Color(0xFFD9D9D9);

  // ── Buttons ────────────────────────────────────────────────────────────────

  /// Primary CTA button fill. Consistent across all screens.
  static const buttonPrimary = Color(0xFF000000);

  /// Disabled primary CTA fill.
  /// Source: #BDBDBD from claim_username (only screen with explicit disabled state).
  static const buttonDisabled = Color(0xFFBDBDBD);

  /// Button label and icon color.
  static const buttonLabel = Color(0xFFFFFFFF);

  // ── Inputs ─────────────────────────────────────────────────────────────────

  /// Underline divider color used below text inputs.
  /// Source: Colors.black (name, username) — consistent with inputText color.
  static const inputUnderline = Color(0xFF000000);
}
