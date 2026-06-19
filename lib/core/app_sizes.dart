/// Layout and sizing tokens for InnerSky.
///
/// All values are "design-unit" values that must be multiplied by the
/// current screen scale factor `s` (from each screen's `_s()` helper)
/// before use, unless the doc-comment says otherwise.
abstract final class AppSizes {
  // ── Touch Targets ──────────────────────────────────────────────────────────

  /// Minimum interactive tap area per Material accessibility guidelines.
  /// This is in real logical pixels — do NOT multiply by scale.
  static const touchTarget = 48.0;

  // ── Close Button ───────────────────────────────────────────────────────────

  /// Visible close icon size (design units). Multiply by `s`.
  /// Source: ~27–30 across birth_time and claim_username.  Midpoint chosen.
  static const closeIconVisible = 28.0;

  /// Circle container outer size (design units). Multiply by `s`.
  /// Source: 66 in claim_username; birth_time uses max(48, 86*s) which is
  /// larger — that screen keeps its own close button style (intentional).
  static const closeContainerSize = 66.0;

  // ── Primary CTA Button ─────────────────────────────────────────────────────

  /// Button body height (design units). Multiply by `s`.
  /// Source: 104 consistent across name, date, location, username, time.
  static const primaryButtonHeight = 104.0;

  /// Button corner radius (design units). Multiply by `s`.
  /// Source: 24 used in name, location, username.
  /// Date was 0 (square) — unified here. Time was pill — unified here.
  static const primaryButtonRadius = 24.0;

  /// Gap between the "CONTINUE" label and the → arrow (design units).
  /// Source: 44 used in name, location, username.
  static const primaryButtonArrowGap = 44.0;

  // ── Progress Indicator ─────────────────────────────────────────────────────

  /// Width of each progress bar segment (design units). Multiply by `s`.
  /// Source: 64 used in enter_name (strongest editorial screen).
  static const progressBarWidth = 64.0;

  /// Height of each progress bar segment (design units). Multiply by `s`.
  /// Source: 8 used in enter_name.
  static const progressBarHeight = 8.0;

  /// Horizontal margin on each side of a segment (design units). Multiply by `s`.
  /// Source: normalised from the 25-pixel gap in enter_name (half = 12.5 ≈ 12).
  static const progressBarHalfGap = 12.0;

  // ── Onboarding Screen Layout ───────────────────────────────────────────────

  /// Horizontal inset for the CTA button from screen edges (design units).
  /// Source: 55 used in name + username (most-used value; 47/52/86 were outliers).
  static const ctaHorizontalInset = 55.0;

  /// Distance from bottom safe-area edge to bottom of CTA button (design units).
  /// Source: ~86–98 across screens; 86 is the median.
  static const ctaBottomInset = 86.0;

  /// Distance from bottom of CTA to top of progress indicator (design units).
  /// Source: derived from enter_name layout: progress bottom = 40, CTA bottom = 98.
  static const progressBottomInset = 38.0;
}
