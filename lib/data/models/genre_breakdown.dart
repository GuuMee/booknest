// lib/data/models/genre_breakdown.dart

import 'package:flutter/material.dart';            // Color
                                                   // Colors
                                                   // Colors.blue
                                                   // .value

// ─────────────────────────────────────────────────────────────────────────────

class GenreBreakdown {
  final String genre;
  final int bookCount;
  final int minutesRead;
  final double percentage;
  final Color color;

  const GenreBreakdown({
    required this.genre,
    required this.bookCount,
    required this.minutesRead,
    required this.percentage,
    required this.color,
  });

  factory GenreBreakdown.fromJson(Map<String, dynamic> json) {
    return GenreBreakdown(
      genre: json['genre'] ?? '',
      bookCount: json['bookCount'] ?? 0,
      minutesRead: json['minutesRead'] ?? 0,
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      color: Color(json['color'] ?? Colors.blue.value),
    );
  }
}