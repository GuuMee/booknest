// lib/data/models/bookmark.dart

import 'package:equatable/equatable.dart';    // Equatable
                                              // List<Object?>
                                              // .props

// ─────────────────────────────────────────────────────────────────────────────

class Bookmark extends Equatable {
  final String? id;
  final String bookId;
  final int page;
  final int chapter;
  final String chapterTitle;
  final String? note;
  final DateTime createdAt;

  const Bookmark({
    this.id,
    required this.bookId,
    required this.page,
    required this.chapter,
    required this.chapterTitle,
    this.note,
    required this.createdAt,
  });

  // ─────────────────────────────────────────
  // FACTORY
  // ─────────────────────────────────────────

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      bookId: json['bookId'] ?? '',
      page: json['page'] ?? 0,
      chapter: json['chapter'] ?? 0,
      chapterTitle: json['chapterTitle'] ?? '',
      note: json['note'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'page': page,
        'chapter': chapter,
        'chapterTitle': chapterTitle,
        'note': note,
        'createdAt': createdAt.toIso8601String(),
      };

  // ─────────────────────────────────────────
  // COPY WITH
  // ─────────────────────────────────────────

  Bookmark copyWith({String? note}) {
    return Bookmark(
      id: id,
      bookId: bookId,
      page: page,
      chapter: chapter,
      chapterTitle: chapterTitle,
      note: note ?? this.note,
      createdAt: createdAt,
    );
  }

  // ─────────────────────────────────────────
  // EQUATABLE
  // ─────────────────────────────────────────

  @override
  List<Object?> get props => [id, bookId, page, chapter];
}