// lib/config/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // приватный конструктор

  // ─── Primary Brand Colors ───────────────────────────────
  static const Color primary      = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark  = Color(0xFF4A42DB);

  // ─── Secondary ──────────────────────────────────────────
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent    = Color(0xFFFFC75F);

  // ─── Backgrounds ────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color backgroundDark  = Color(0xFF1A1A2E);
  static const Color surfaceLight    = Color(0xFFFFFFFF);
  static const Color surfaceDark     = Color(0xFF16213E);

  // ─── Text Colors ────────────────────────────────────────
  static const Color textPrimary       = Color(0xFF1A1A2E);
  static const Color textSecondary     = Color(0xFF6B7280);
  static const Color textHint          = Color(0xFFADB5BD);
  static const Color textPrimaryDark   = Color(0xFFF8F9FE);
  static const Color textSecondaryDark = Color(0xFFADB5BD);

  // ─── Border & Divider ───────────────────────────────────
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark  = Color(0xFF2D2D44);
  static const Color divider     = Color(0xFFF3F4F6);

  // ─── Shadow ─────────────────────────────────────────────
  static const Color shadowLight = Color(0x1A6C63FF);
  static const Color shadowDark  = Color(0x33000000);

  // ─── Reading Modes ──────────────────────────────────────
  static const Color sepiaBackground = Color(0xFFF4ECD8);
  static const Color sepiaText       = Color(0xFF5C4A1E);
  static const Color darkReaderBg    = Color(0xFF1E1E1E);
  static const Color darkReaderText  = Color(0xFFE0E0E0);

  // ─── Status Colors ──────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color error   = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFF9800);
  static const Color info    = Color(0xFF2196F3);

  // ─── Rating ─────────────────────────────────────────────
  static const Color starFilled = Color(0xFFFFB800);
  static const Color starEmpty  = Color(0xFFE0E0E0);

  // ─── Kids Mode Colors ───────────────────────────────────
  static const Color kidsBlue   = Color(0xFF42A5F5);
  static const Color kidsGreen  = Color(0xFF66BB6A);
  static const Color kidsOrange = Color(0xFFFFB74D);
  static const Color kidsPink   = Color(0xFFEF5350);
  static const Color kidsPurple = Color(0xFFAB47BC);
  static const Color kidsYellow = Color(0xFFFFEE58);

  // ─── Gradients ──────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9D97FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kidsGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), Color(0xFF66BB6A), Color(0xFFFFB74D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF4A42DB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}