// lib/data/repositories/stats_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';  // FirebaseFirestore
                                                        // DocumentReference
                                                        // CollectionReference
                                                        // SetOptions
                                                        // Transaction
                                                        // .collection()
                                                        // .doc()
                                                        // .get()
                                                        // .add()
                                                        // .set()
                                                        // .runTransaction()

// Data - Models
import '../models/reading_stats.dart';                  // ReadingStats
                                                        // .totalBooksRead
                                                        // .totalMinutesRead
                                                        // .totalPagesRead
                                                        // .longestStreak
                                                        // .genreDistribution
                                                        // .booksReadThisYear
                                                        // .yearlyGoal
                                                        // .fromJson()
import '../models/achievement.dart';                    // Achievement
                                                        // .id
                                                        // .title
                                                        // .description
                                                        // .icon
                                                        // .isUnlocked
                                                        // .progress
                                                        // .target
                                                        // .current
                                                        // .toJson()
// ─────────────────────────────────────────────────────────────────────────────

class StatsRepository {
  final FirebaseFirestore _firestore;

  StatsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  DocumentReference _userStatsRef(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('data')
          .doc('stats');

  CollectionReference _sessionsRef(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_sessions');

  // ===== GET STATS =====
  Future<ReadingStats> getStats(String userId) async {
    final doc = await _userStatsRef(userId).get();

    if (!doc.exists) {
      return const ReadingStats();
    }

    final data = doc.data() as Map<String, dynamic>;

    // Calculate achievements
    final stats = ReadingStats.fromJson(data);
    final achievements = _calculateAchievements(stats);

    return ReadingStats.fromJson({
      ...data,
      'achievements':
          achievements.map((a) => a.toJson()).toList(),
    });
  }

  // ===== RECORD SESSION =====
  Future<void> recordSession({
    required String userId,
    required String bookId,
    required int durationMinutes,
    required int pagesRead,
  }) async {
    final now = DateTime.now();
    final dateKey =
        '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    // Save session
    await _sessionsRef(userId).add({
      'bookId': bookId,
      'durationMinutes': durationMinutes,
      'pagesRead': pagesRead,
      'timestamp': now.toIso8601String(),
      'date': dateKey,
    });

    // Update stats
    await _firestore.runTransaction((transaction) async {
      final statsDoc =
          await transaction.get(_userStatsRef(userId));
      final data = statsDoc.exists
          ? statsDoc.data() as Map<String, dynamic>
          : <String, dynamic>{};

      // Update totals
      final totalMinutes =
          (data['totalReadingMinutes'] ?? 0) +
              durationMinutes;
      final totalPages =
          (data['totalPagesRead'] ?? 0) + pagesRead;

      // Update reading days
      final readingDays =
          List<String>.from(data['readingDays'] ?? []);
      if (!readingDays.contains(dateKey)) {
        readingDays.add(dateKey);
      }

      // Calculate streak
      final streakInfo = _calculateStreak(readingDays);

      // Calculate avg session
      final sessionCount =
          (data['sessionCount'] ?? 0) + 1;
      final avgSession = totalMinutes ~/ sessionCount;

      // Calculate avg pages per day
      final daysActive =
          readingDays.length.clamp(1, 99999);
      final avgPagesPerDay = totalPages ~/ daysActive;

      transaction.set(
        _userStatsRef(userId),
        {
          ...data,
          'totalReadingMinutes': totalMinutes,
          'totalPagesRead': totalPages,
          'readingDays': readingDays,
          'currentStreak': streakInfo['current'],
          'longestStreak': streakInfo['longest'],
          'sessionCount': sessionCount,
          'avgSessionMinutes': avgSession,
          'avgPagesPerDay': avgPagesPerDay,
          'lastReadDate': dateKey,
        },
        SetOptions(merge: true),
      );
    });
  }

  // ===== MARK BOOK COMPLETE =====
  Future<void> markBookComplete({
    required String userId,
    required String bookId,
    String? genre,
    double? rating,
  }) async {
    final now = DateTime.now();

    await _firestore.runTransaction((transaction) async {
      final statsDoc =
          await transaction.get(_userStatsRef(userId));
      final data = statsDoc.exists
          ? statsDoc.data() as Map<String, dynamic>
          : <String, dynamic>{};

      final totalBooks =
          (data['totalBooksRead'] ?? 0) + 1;
      final booksThisYear = now.year.toString() ==
              (data['currentYear'] ??
                  now.year.toString())
          ? (data['booksReadThisYear'] ?? 0) + 1
          : 1;

      // Monthly books
      final monthlyBooks = Map<String, dynamic>.from(
        data['monthlyBooks'] ?? {},
      );
      final monthKey = now.month.toString();
      monthlyBooks[monthKey] =
          (monthlyBooks[monthKey] ?? 0) + 1;

      // Genre distribution
      final genreDist = Map<String, dynamic>.from(
        data['genreDistribution'] ?? {},
      );
      if (genre != null && genre.isNotEmpty) {
        genreDist[genre] =
            (genreDist[genre] ?? 0) + 1;
      }

      // Average rating
      double avgRating =
          (data['averageRating'] ?? 0.0).toDouble();
      if (rating != null) {
        final totalRatings =
            (data['totalRatings'] ?? 0) + 1;
        final ratingSum =
            (data['ratingSum'] ?? 0.0).toDouble() +
                rating;
        avgRating = ratingSum / totalRatings;

        data['totalRatings'] = totalRatings;
        data['ratingSum'] = ratingSum;
      }

      // Completed books list
      final completedBooks =
          List<String>.from(
        data['completedBooks'] ?? [],
      );
      if (!completedBooks.contains(bookId)) {
        completedBooks.add(bookId);
      }

      transaction.set(
        _userStatsRef(userId),
        {
          ...data,
          'totalBooksRead': totalBooks,
          'booksReadThisYear': booksThisYear,
          'currentYear': now.year.toString(),
          'monthlyBooks': monthlyBooks,
          'genreDistribution': genreDist,
          'averageRating': double.parse(
            avgRating.toStringAsFixed(1),
          ),
          'completedBooks': completedBooks,
          'lastCompletedDate': now.toIso8601String(),
        },
        SetOptions(merge: true),
      );
    });
  }

  // ===== CALCULATE STREAK =====
  Map<String, int> _calculateStreak(
    List<String> readingDays,
  ) {
    if (readingDays.isEmpty) {
      return {'current': 0, 'longest': 0};
    }

    final sortedDays = readingDays
        .map((d) => DateTime.parse(d))
        .toList()
      ..sort();

    int currentStreak = 1;
    int longestStreak = 1;
    int tempStreak = 1;

    for (int i = 1; i < sortedDays.length; i++) {
      final diff = sortedDays[i]
          .difference(sortedDays[i - 1])
          .inDays;

      if (diff == 1) {
        tempStreak++;
      } else if (diff > 1) {
        tempStreak = 1;
      }

      if (tempStreak > longestStreak) {
        longestStreak = tempStreak;
      }
    }

    // Check if current streak is active
    // (last read today or yesterday)
    final today = DateTime.now();
    final lastRead = sortedDays.last;
    final daysSinceLastRead =
        DateTime(today.year, today.month, today.day)
            .difference(
              DateTime(
                lastRead.year,
                lastRead.month,
                lastRead.day,
              ),
            )
            .inDays;

    if (daysSinceLastRead <= 1) {
      currentStreak = tempStreak;
    } else {
      currentStreak = 0;
    }

    return {
      'current': currentStreak,
      'longest': longestStreak,
    };
  }

  // ===== CALCULATE ACHIEVEMENTS =====
  List<Achievement> _calculateAchievements(
    ReadingStats stats,
  ) {
    final definitions = AchievementDefinitions.all();

    return definitions.map((def) {
      int current = 0;

      switch (def.id) {
        case 'first_book':
          current =
              stats.totalBooksRead.clamp(0, 1);
          break;
        case 'bookworm':
          current =
              stats.totalBooksRead.clamp(0, 10);
          break;
        case 'library_builder':
          current =
              stats.totalBooksRead.clamp(0, 25);
          break;
        case 'century_reader':
          current =
              stats.totalBooksRead.clamp(0, 100);
          break;
        case 'streak_7':
          current =
              stats.longestStreak.clamp(0, 7);
          break;
        case 'streak_30':
          current =
              stats.longestStreak.clamp(0, 30);
          break;
        case 'streak_100':
          current =
              stats.longestStreak.clamp(0, 100);
          break;
        case 'genre_explorer':
          current = stats.genreDistribution.length
              .clamp(0, 5);
          break;
        case 'page_turner':
          current =
              stats.totalPagesRead.clamp(0, 10000);
          break;
        case 'yearly_goal':
          current =
              stats.booksReadThisYear >=
                      stats.yearlyGoal
                  ? 1
                  : 0;
          break;
        default:
          current = 0;
      }

      final progress = def.target > 0
          ? (current / def.target).clamp(0.0, 1.0)
          : 0.0;

      return Achievement(
        id: def.id,
        title: def.title,
        description: def.description,
        icon: def.icon,
        isUnlocked: current >= def.target,
        progress: progress,
        target: def.target,
        current: current,
      );
    }).toList()
      ..sort((a, b) {
        // Unlocked first, then by progress
        if (a.isUnlocked && !b.isUnlocked) return -1;
        if (!a.isUnlocked && b.isUnlocked) return 1;
        return b.progress.compareTo(a.progress);
      });
  }
}