// lib/config/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._(); // приватный конструктор

  // ─── Headings ───────────────────────────────────────────
  static TextStyle heading1 = GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle heading2 = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static TextStyle heading3 = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static TextStyle heading4 = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle heading5 = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ─── Body ───────────────────────────────────────────────
  static TextStyle bodyLarge = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle bodySmall = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ─── Subtitle ───────────────────────────────────────────
  static TextStyle subtitle1 = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle subtitle2 = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ─── Label / Caption ────────────────────────────────────
  static TextStyle label = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  static TextStyle caption = GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.3,
  );

  static TextStyle overline = GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  // ─── Button ─────────────────────────────────────────────
  static TextStyle buttonLarge = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static TextStyle buttonMedium = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static TextStyle buttonSmall = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  // ─── Reader Styles ──────────────────────────────────────
  static TextStyle readerBody = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.8,
    letterSpacing: 0.2,
  );

  static TextStyle readerBodySmall = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  static TextStyle readerBodyLarge = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  static TextStyle readerChapterTitle = GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  // ─── Kids Typography ────────────────────────────────────
  static TextStyle kidsHeading = GoogleFonts.baloo2(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    // ❌ убрали hardcoded color — цвет задаётся через copyWith()
    height: 1.2,
  );

  static TextStyle kidsHeadingSmall = GoogleFonts.baloo2(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle kidsBody = GoogleFonts.baloo2(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle kidsBodySmall = GoogleFonts.baloo2(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle kidsButton = GoogleFonts.baloo2(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
}