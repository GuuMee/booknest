// lib/presentation/blocs/stats/stats_bloc.dart

import 'package:equatable/equatable.dart';              // Equatable
                                                        // List<Object?>
                                                        // .props
import 'package:flutter/foundation.dart';               // debugPrint
import 'package:flutter_bloc/flutter_bloc.dart';        // Bloc
                                                        // Emitter
                                                        // on<Event>

// Data - Models
import '../../../data/models/reading_stats.dart';       // ReadingStats
                                                        // .totalBooksRead
                                                        // .totalMinutesRead
                                                        // .totalPagesRead
                                                        // .averageMinutesPerDay
import '../../../data/models/daily_reading.dart';       // DailyReading
import '../../../data/models/genre_breakdown.dart';     // GenreBreakdown
import '../../../data/models/achievement.dart';         // Achievement
import '../../../data/models/reading_session.dart';     // ReadingSession

// Data - Repositories
import '../../../data/repositories/stats_repository.dart';
                                                        // StatsRepository
                                                        // .getReadingStats()
                                                        // .getWeeklyData()
                                                        // .getMonthlyData()
                                                        // .getCurrentStreak()
                                                        // .getLongestStreak()
                                                        // .getGenreBreakdown()
                                                        // .recordSession()
                                                        // .markBookComplete()
import '../../../data/repositories/achievement_repository.dart';
                                                        // AchievementRepository
                                                        // .getAchievements()
                                                        // .checkAndUnlockAchievements()

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class StatsEvent extends Equatable {
  const StatsEvent();
  @override
  List<Object?> get props => [];
}

class LoadStats extends StatsEvent {}

class LoadWeeklyStats extends StatsEvent {}

class LoadMonthlyStats extends StatsEvent {}

class LoadYearlyStats extends StatsEvent {}

class RecordReadingSession extends StatsEvent {
  final String bookId;
  final int durationSeconds;
  final int pagesRead;
  final DateTime date;

  const RecordReadingSession({
    required this.bookId,
    required this.durationSeconds,
    required this.pagesRead,
    required this.date,
  });

  @override
  List<Object?> get props => [
        bookId,
        durationSeconds,
        pagesRead,
        date,
      ];
}

class MarkBookComplete extends StatsEvent {
  final String bookId;
  final String? genre;
  final double? rating;

  const MarkBookComplete({
    required this.bookId,
    this.genre,
    this.rating,
  });

  @override
  List<Object?> get props => [
        bookId,
        genre,
        rating,
      ];
}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class StatsState extends Equatable {
  const StatsState();
  @override
  List<Object?> get props => [];
}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final ReadingStats stats;
  final List<DailyReading> weeklyData;
  final List<DailyReading> monthlyData;
  final int currentStreak;
  final int longestStreak;
  final int totalBooksRead;
  final int totalMinutesRead;
  final int totalPagesRead;
  final double averageMinutesPerDay;
  final List<GenreBreakdown> genreBreakdown;
  final List<Achievement> achievements;

  const StatsLoaded({
    required this.stats,
    required this.weeklyData,
    required this.monthlyData,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalBooksRead,
    required this.totalMinutesRead,
    required this.totalPagesRead,
    required this.averageMinutesPerDay,
    required this.genreBreakdown,
    required this.achievements,
  });

  @override
  List<Object?> get props => [
        stats,
        weeklyData,
        currentStreak,
        totalBooksRead,
        totalMinutesRead,
      ];
}

class StatsError extends StatsState {
  final String message;
  const StatsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _statsRepository;
  final AchievementRepository _achievementRepository;

  StatsBloc({
    required StatsRepository statsRepository,
    required AchievementRepository achievementRepository,
  })  : _statsRepository = statsRepository,
        _achievementRepository = achievementRepository,
        super(StatsInitial()) {
    on<LoadStats>(_onLoadStats);
    on<LoadWeeklyStats>(_onLoadWeekly);
    on<RecordReadingSession>(_onRecordSession);
    on<MarkBookComplete>(_onMarkComplete); // ✅ FIX 1: was missing
  }

  // ─────────────────────────────────────────
  // LOAD STATS
  // ─────────────────────────────────────────

  Future<void> _onLoadStats(
    LoadStats event,
    Emitter<StatsState> emit,
  ) async {
    emit(StatsLoading());

    try {
      final stats =
          await _statsRepository.getReadingStats();
      final weeklyData =
          await _statsRepository.getWeeklyData();
      final monthlyData =
          await _statsRepository.getMonthlyData();
      final streak =
          await _statsRepository.getCurrentStreak();
      final longestStreak =
          await _statsRepository.getLongestStreak();
      final genreBreakdown =
          await _statsRepository.getGenreBreakdown();
      final achievements =
          await _achievementRepository.getAchievements();

      emit(StatsLoaded(
        stats: stats,
        weeklyData: weeklyData,
        monthlyData: monthlyData,
        currentStreak: streak,
        longestStreak: longestStreak,
        totalBooksRead: stats.totalBooksRead,
        totalMinutesRead: stats.totalMinutesRead,
        totalPagesRead: stats.totalPagesRead,
        averageMinutesPerDay:
            stats.averageMinutesPerDay,
        genreBreakdown: genreBreakdown,
        achievements: achievements,
      ));
    } catch (e) {
      emit(StatsError(message: e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // LOAD WEEKLY
  // ─────────────────────────────────────────

  Future<void> _onLoadWeekly(
    LoadWeeklyStats event,
    Emitter<StatsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! StatsLoaded) return;

    try {
      final weeklyData =
          await _statsRepository.getWeeklyData();

      emit(StatsLoaded(
        stats: currentState.stats,
        weeklyData: weeklyData,
        monthlyData: currentState.monthlyData,
        currentStreak: currentState.currentStreak,
        longestStreak: currentState.longestStreak,
        totalBooksRead: currentState.totalBooksRead,
        totalMinutesRead:
            currentState.totalMinutesRead,
        totalPagesRead: currentState.totalPagesRead,
        averageMinutesPerDay:
            currentState.averageMinutesPerDay,
        genreBreakdown: currentState.genreBreakdown,
        achievements: currentState.achievements,
      ));
    } catch (_) {}
  }

  // ─────────────────────────────────────────
  // RECORD SESSION
  // ─────────────────────────────────────────

  Future<void> _onRecordSession(
    RecordReadingSession event,
    Emitter<StatsState> emit,
  ) async {
    try {
      await _statsRepository.recordSession(
        ReadingSession(
          bookId: event.bookId,
          durationSeconds: event.durationSeconds,
          pagesRead: event.pagesRead,
          date: event.date,
        ),
      );

      // Check for new achievements
      await _achievementRepository
          .checkAndUnlockAchievements(
        durationSeconds: event.durationSeconds,
        pagesRead: event.pagesRead,
      );

      // Reload stats
      add(LoadStats());
    } catch (e) {
      debugPrint('Failed to record session: $e');
    }
  }

  // ─────────────────────────────────────────
  // MARK BOOK COMPLETE
  // ─────────────────────────────────────────

  Future<void> _onMarkComplete(
    MarkBookComplete event,
    Emitter<StatsState> emit,
  ) async {
    // ✅ FIX 2: removed _auth.currentUser?.uid
    // because this bloc has no FirebaseAuth.
    // _statsRepository handles auth internally.
    try {
      await _statsRepository.markBookComplete(
        bookId: event.bookId,
        genre: event.genre,
        rating: event.rating,
      );

      // Reload stats
      add(LoadStats());
    } catch (e) {
      debugPrint('Failed to mark complete: $e');
    }
  }
}