// lib/data/models/reading_stats.dart

import 'package:equatable/equatable.dart';        // Equatable
                                                   // .props

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — ReadingStats
// ─────────────────────────────────────────────────────────────────────────────

class ReadingStats extends Equatable {
  final int currentStreak;
  final int bestStreak;
  final List<bool> weeklyActivity;     // 7 bools Mon-Sun
  final int totalBooksRead;
  final int totalMinutesRead;
  final int totalPagesRead;
  final int avgPagesPerHour;
  final int avgMinutesPerDay;
  final int avgDaysPerBook;
  final int dailyGoalMinutes;
  final List<int> dailyMinutes;        // 7 ints Mon-Sun
  final List<DayActivity> monthlyData;
  final Map<String, int> genreBreakdown;
  final List<Achievement> achievements;

  // ✅ ADDED from old version
  final double averageRating;
  final int booksReadThisYear;
  final int yearlyGoal;
  final Map<int, int> monthlyBooks;    // month -> count
  final int avgSessionMinutes;
  final int avgPagesPerDay;
  final List<String> readingDays;      // 'yyyy-MM-dd'

  // ─────────────────────────────────────────
  // GETTERS
  // ─────────────────────────────────────────

  int get unlockedAchievements =>
      achievements
          .where((a) => a.isUnlocked)
          .length;

  int get totalAchievements =>
      achievements.length;

  // ─────────────────────────────────────────
  // CONSTRUCTOR
  // ─────────────────────────────────────────

  const ReadingStats({
    required this.currentStreak,
    required this.bestStreak,
    required this.weeklyActivity,
    required this.totalBooksRead,
    required this.totalMinutesRead,
    required this.totalPagesRead,
    required this.avgPagesPerHour,
    required this.avgMinutesPerDay,
    required this.avgDaysPerBook,
    required this.dailyGoalMinutes,
    required this.dailyMinutes,
    required this.monthlyData,
    required this.genreBreakdown,
    required this.achievements,
    // ✅ ADDED from old version
    this.averageRating = 0.0,
    this.booksReadThisYear = 0,
    this.yearlyGoal = 12,
    this.monthlyBooks = const {},
    this.avgSessionMinutes = 0,
    this.avgPagesPerDay = 0,
    this.readingDays = const [],
  });

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  factory ReadingStats.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReadingStats(
      currentStreak:
          json['currentStreak'] ?? 0,
      bestStreak:
          json['bestStreak'] ?? 0,
      weeklyActivity:
          (json['weeklyActivity']
                      as List<dynamic>?)
                  ?.map((e) => e as bool)
                  .toList() ??
              List.filled(7, false),
      totalBooksRead:
          json['totalBooksRead'] ?? 0,
      totalMinutesRead:
          json['totalMinutesRead'] ?? 0,
      totalPagesRead:
          json['totalPagesRead'] ?? 0,
      avgPagesPerHour:
          json['avgPagesPerHour'] ?? 0,
      avgMinutesPerDay:
          json['avgMinutesPerDay'] ?? 0,
      avgDaysPerBook:
          json['avgDaysPerBook'] ?? 0,
      dailyGoalMinutes:
          json['dailyGoalMinutes'] ?? 30,
      dailyMinutes:
          (json['dailyMinutes']
                      as List<dynamic>?)
                  ?.map((e) => e as int)
                  .toList() ??
              List.filled(7, 0),
      monthlyData:
          (json['monthlyData']
                      as List<dynamic>?)
                  ?.map(
                    (e) => DayActivity.fromJson(
                      e as Map<String, dynamic>,
                    ),
                  )
                  .toList() ??
              [],
      genreBreakdown: Map<String, int>.from(
        json['genreBreakdown'] ?? {},
      ),
      achievements:
          (json['achievements']
                      as List<dynamic>?)
                  ?.map(
                    (e) => Achievement.fromJson(
                      e as Map<String, dynamic>,
                    ),
                  )
                  .toList() ??
              [],
      // ✅ ADDED from old version
      averageRating:
          (json['averageRating'] ?? 0.0)
              .toDouble(),
      booksReadThisYear:
          json['booksReadThisYear'] ?? 0,
      yearlyGoal:
          json['yearlyGoal'] ?? 12,
      monthlyBooks:
          (json['monthlyBooks']
                      as Map<String, dynamic>?)
                  ?.map(
                    (k, v) => MapEntry(
                      int.parse(k),
                      v as int,
                    ),
                  ) ??
              {},
      avgSessionMinutes:
          json['avgSessionMinutes'] ?? 0,
      avgPagesPerDay:
          json['avgPagesPerDay'] ?? 0,
      readingDays: List<String>.from(
        json['readingDays'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'currentStreak': currentStreak,
        'bestStreak': bestStreak,
        'weeklyActivity': weeklyActivity,
        'totalBooksRead': totalBooksRead,
        'totalMinutesRead': totalMinutesRead,
        'totalPagesRead': totalPagesRead,
        'avgPagesPerHour': avgPagesPerHour,
        'avgMinutesPerDay': avgMinutesPerDay,
        'avgDaysPerBook': avgDaysPerBook,
        'dailyGoalMinutes': dailyGoalMinutes,
        'dailyMinutes': dailyMinutes,
        'monthlyData': monthlyData
            .map((e) => e.toJson())
            .toList(),
        'genreBreakdown': genreBreakdown,
        'achievements': achievements
            .map((e) => e.toJson())
            .toList(),
        // ✅ ADDED from old version
        'averageRating': averageRating,
        'booksReadThisYear': booksReadThisYear,
        'yearlyGoal': yearlyGoal,
        'monthlyBooks': monthlyBooks.map(
          (k, v) => MapEntry(k.toString(), v),
        ),
        'avgSessionMinutes': avgSessionMinutes,
        'avgPagesPerDay': avgPagesPerDay,
        'readingDays': readingDays,
      };

  // ─────────────────────────────────────────
  // EMPTY
  // ─────────────────────────────────────────

  static ReadingStats get empty => ReadingStats(
        currentStreak: 0,
        bestStreak: 0,
        weeklyActivity: List.filled(7, false),
        totalBooksRead: 0,
        totalMinutesRead: 0,
        totalPagesRead: 0,
        avgPagesPerHour: 0,
        avgMinutesPerDay: 0,
        avgDaysPerBook: 0,
        dailyGoalMinutes: 30,
        dailyMinutes: List.filled(7, 0),
        monthlyData: [],
        genreBreakdown: {},
        achievements: [],
        // ✅ ADDED from old version
        averageRating: 0.0,
        booksReadThisYear: 0,
        yearlyGoal: 12,
        monthlyBooks: {},
        avgSessionMinutes: 0,
        avgPagesPerDay: 0,
        readingDays: [],
      );

  // ─────────────────────────────────────────
  // EQUATABLE
  // ─────────────────────────────────────────

  @override
  List<Object?> get props => [
        totalBooksRead,
        totalPagesRead,
        totalMinutesRead,
        currentStreak,
        bestStreak,
        booksReadThisYear,
        achievements,
      ];
}

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — DayActivity
// ─────────────────────────────────────────────────────────────────────────────

class DayActivity {
  final DateTime date;
  final int minutesRead;
  final int pagesRead;

  const DayActivity({
    required this.date,
    required this.minutesRead,
    required this.pagesRead,
  });

  factory DayActivity.fromJson(
    Map<String, dynamic> json,
  ) {
    return DayActivity(
      date: DateTime.parse(
        json['date'] as String,
      ),
      minutesRead: json['minutesRead'] ?? 0,
      pagesRead: json['pagesRead'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'minutesRead': minutesRead,
        'pagesRead': pagesRead,
      };
}

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — Achievement
// ─────────────────────────────────────────────────────────────────────────────

class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double progress;              // 0.0 to 1.0

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0.0,
  });

  factory Achievement.fromJson(
    Map<String, dynamic> json,
  ) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description:
          json['description'] as String,
      emoji: json['emoji'] as String,
      isUnlocked:
          json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(
              json['unlockedAt'] as String,
            )
          : null,
      progress:
          (json['progress'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'emoji': emoji,
        'isUnlocked': isUnlocked,
        'unlockedAt':
            unlockedAt?.toIso8601String(),
        'progress': progress,
      };

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    bool? isUnlocked,
    DateTime? unlockedAt,
    double? progress,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description:
          description ?? this.description,
      emoji: emoji ?? this.emoji,
      isUnlocked:
          isUnlocked ?? this.isUnlocked,
      unlockedAt:
          unlockedAt ?? this.unlockedAt,
      progress: progress ?? this.progress,
    );
  }
}