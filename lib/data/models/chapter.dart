// lib/data/models/chapter.dart

import 'package:equatable/equatable.dart';    // Equatable
                                              // List<Object?>
                                              // .props

// ─────────────────────────────────────────────────────────────────────────────

class Chapter extends Equatable {
  final String id;
  final String bookId;
  final int index;
  final String title;
  final String? subtitle;
  final String content;
  final int wordCount;

  const Chapter({
    required this.id,
    required this.bookId,
    required this.index,
    required this.title,
    this.subtitle,
    required this.content,
    required this.wordCount,
  });

  // ─────────────────────────────────────────
  // FACTORY
  // ─────────────────────────────────────────

  factory Chapter.fromJson(Map<String, dynamic> json) {
    final content = json['content'] ?? '';
    return Chapter(
      id: json['id'] ?? '',
      bookId: json['bookId'] ?? '',
      index: json['index'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      content: content,
      wordCount: content.split(' ').length,
    );
  }

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'index': index,
        'title': title,
        'subtitle': subtitle,
        'content': content,
        'wordCount': wordCount,
      };

  // ─────────────────────────────────────────
  // EQUATABLE
  // ─────────────────────────────────────────

  @override
  List<Object?> get props => [id, bookId, index, title];
}