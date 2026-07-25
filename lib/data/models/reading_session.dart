// lib/data/models/reading_session.dart

// No imports needed                               // Only Dart primitives
                                                   // int, String
                                                   // DateTime
                                                   // Map<String, dynamic>

// ─────────────────────────────────────────────────────────────────────────────

class ReadingSession {
  final String? id;
  final String bookId;
  final int durationSeconds;
  final int pagesRead;
  final DateTime date;

  const ReadingSession({
    this.id,
    required this.bookId,
    required this.durationSeconds,
    required this.pagesRead,
    required this.date,
  });

  int get durationMinutes => durationSeconds ~/ 60;

  factory ReadingSession.fromJson(Map<String, dynamic> json) {
    return ReadingSession(
      id: json['id'],
      bookId: json['bookId'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      pagesRead: json['pagesRead'] ?? 0,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'durationSeconds': durationSeconds,
        'pagesRead': pagesRead,
        'date': date.toIso8601String(),
      };
}