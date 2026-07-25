// lib/core/extensions/string_extensions.dart

// No imports required:
// String     — dart:core (auto-imported)
// RegExp     — dart:core (auto-imported)
// bool       — dart:core (auto-imported)
// int        — dart:core (auto-imported)

// ─────────────────────────────────────────────────────────────────────────────
// EXTENSION
// ─────────────────────────────────────────────────────────────────────────────

extension StringExtensions on String {
  // ─────────────────────────────────────────
  // CAPITALIZE
  // ─────────────────────────────────────────

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String capitalizeEach() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.capitalize())
        .join(' ');
  }

  // ─────────────────────────────────────────
  // TRUNCATE
  // ─────────────────────────────────────────

  String truncate(
    int maxLength, {
    String suffix = '...',
  }) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // ─────────────────────────────────────────
  // VALIDATION
  // ─────────────────────────────────────────

  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool get isValidPassword => length >= 6;
}