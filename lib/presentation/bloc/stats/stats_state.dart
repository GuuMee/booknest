// lib/presentation/blocs/stats/stats_state.dart

import '../../../domain/models/reading_stats.dart'; // ReadingStats

abstract class StatsState {}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final ReadingStats stats;
  StatsLoaded({required this.stats});
}

class StatsError extends StatsState {
  final String message;
  StatsError({required this.message});
}