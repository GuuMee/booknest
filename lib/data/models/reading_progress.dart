// lib/data/models/reading_progress.dart

import 'package:equatable/equatable.dart';    // Equatable
                                              // List<Object?>
                                              // .props

// ─────────────────────────────────────────────────────────────────────────────

class ReadingProgress extends Equatable {
  final String bookId;
  final int currentPage;
  final int totalPages;
  final int currentChapter;
  final double progress;
  final DateTime lastReadAt;

  const ReadingProgress({
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    required this.currentChapter,
    required this.progress,
    required this.lastReadAt,
  });

  // ─────────────────────────────────────────
  // FACTORY
  // ─────────────────────────────────────────

  factory ReadingProgress.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReadingProgress(
      bookId: json['bookId'] ?? '',
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentChapter: json['currentChapter'] ?? 0,
      progress: (json['progress'] ?? 0.0).toDouble(),
      lastReadAt: json['lastReadAt'] != null
          ? DateTime.parse(json['lastReadAt'])
          : DateTime.now(),
    );
  }

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'currentPage': currentPage,
        'totalPages': totalPages,
        'currentChapter': currentChapter,
        'progress': progress,
        'lastReadAt': lastReadAt.toIso8601String(),
      };

  // ─────────────────────────────────────────
  // EQUATABLE
  // ─────────────────────────────────────────

  @override
  List<Object?> get props => [
        bookId,
        currentPage,
        totalPages,
        progress,
      ];
}