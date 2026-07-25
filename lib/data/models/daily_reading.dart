// lib/data/models/daily_reading.dart

// No imports needed                               // Only Dart primitives
                                                   // int, bool, String
                                                   // DateTime
                                                   // Map<String, dynamic>

// ─────────────────────────────────────────────────────────────────────────────

class DailyReading {
  final DateTime date;
  final int minutesRead;
  final int pagesRead;
  final bool goalMet;

  const DailyReading({
    required this.date,
    required this.minutesRead,
    required this.pagesRead,
    required this.goalMet,
  });

  factory DailyReading.fromJson(Map<String, dynamic> json) {
    return DailyReading(
      date: DateTime.parse(json['date']),
      minutesRead: json['minutesRead'] ?? 0,
      pagesRead: json['pagesRead'] ?? 0,
      goalMet: json['goalMet'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'minutesRead': minutesRead,
        'pagesRead': pagesRead,
        'goalMet': goalMet,
      };
}