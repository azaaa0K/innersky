import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Semantic typography styles for InnerSky.
///
/// All styles accept a scale factor [s] from the screen's `_s()` helper.
/// No values here are invented — every value was found in the existing
/// screen files and the dominant use was selected.
abstract final class AppTypography {
  // ── Screen Title ───────────────────────────────────────────────────────────

  /// Large editorial headline. Playfair Display.
  /// Source: enter_name + claim_username (37, w500) — editorial identity.
  /// Used for: "WHAT'S YOUR NAME?", "CLAIM A USERNAME".
  static TextStyle screenTitle(double s) => GoogleFonts.playfairDisplay(
    fontSize: 37 * s,
    height: 1.06,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 3.8 * s,
  );

  // ── Step Label ─────────────────────────────────────────────────────────────

  /// Small all-caps step counter. Inter.
  /// Source: "STEP  X  OF  5" in enter_name + claim_username (17, w500, #777777).
  static TextStyle stepLabel(double s) => GoogleFonts.inter(
    fontSize: 17 * s,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    letterSpacing: 8.0 * s,
  );

  // ── Subtitle / Descriptor ──────────────────────────────────────────────────

  /// Body subtitle beneath the screen title. Inter.
  /// Source: enter_name + claim_username (17.5, w400, #626262).
  static TextStyle subtitle(double s) => GoogleFonts.inter(
    fontSize: 17.5 * s,
    height: 1.35,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF626262),
    letterSpacing: 1.1 * s,
  );

  // ── Helper / Privacy Copy ──────────────────────────────────────────────────

  /// Privacy notices, helper text below inputs. Inter.
  /// Source: enter_name (16.5, w400, #525252) and enter_birth_time (18, w400, #505050).
  /// Unified at 17, Inter, #525252.
  static TextStyle helperText(double s) => GoogleFonts.inter(
    fontSize: 17 * s,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2 * s,
  );

  // ── Social Header ──────────────────────────────────────────────────────────

  /// Top-left social CTA ("Posting to social? Tag us…"). Inter.
  /// Source: enter_name + claim_username (21, w400, #050505).
  /// enter_birth_date/location used Space Mono 23 — inconsistent, unified to Inter 21.
  static TextStyle socialHeader(double s) => GoogleFonts.inter(
    fontSize: 21 * s,
    height: 1.52,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF050505),
    letterSpacing: 1.1 * s,
    decoration: TextDecoration.none,
  );

  // ── CTA Button Label ───────────────────────────────────────────────────────

  /// Primary CTA button label text. Space Mono.
  /// Source: consistent across all screens (24, w400).
  static TextStyle ctaLabel(double s) => GoogleFonts.spaceMono(
    fontSize: 24 * s,
    fontWeight: FontWeight.w400,
    color: AppColors.buttonLabel,
    letterSpacing: 2.5 * s,
  );

  /// CTA arrow glyph style. Space Mono.
  /// Source: name, location, username used '→' SpaceMono 38 w300.
  static TextStyle ctaArrow(double s) => GoogleFonts.spaceMono(
    fontSize: 38 * s,
    fontWeight: FontWeight.w300,
    color: AppColors.buttonLabel,
    height: 1.0,
  );

  // ── Input ──────────────────────────────────────────────────────────────────

  /// Text field input text. Playfair Display.
  /// Size unified at 46 (username value, middle of 42–58 range).
  static TextStyle inputText(double s) => GoogleFonts.playfairDisplay(
    fontSize: 46 * s,
    height: 1.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: -0.8 * s,
  );

  /// Text field hint. Playfair Display. Same size as inputText.
  static TextStyle inputHint(double s) => GoogleFonts.playfairDisplay(
    fontSize: 46 * s,
    height: 1.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    letterSpacing: -0.8 * s,
  );
}
