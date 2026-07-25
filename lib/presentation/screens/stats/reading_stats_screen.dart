// lib/presentation/screens/stats/reading_stats_screen.dart

import 'package:flutter/material.dart';              // StatelessWidget
                                                      // Widget
                                                      // BuildContext
                                                      // Scaffold
                                                      // AppBar
                                                      // Text
                                                      // TextStyle
                                                      // IconButton
                                                      // Icon
                                                      // Icons
                                                      // Colors
                                                      // Center
                                                      // CircularProgressIndicator
                                                      // Column
                                                      // Row
                                                      // ListView
                                                      // GridView
                                                      // SizedBox
                                                      // Container
                                                      // Expanded
                                                      // Padding
                                                      // EdgeInsets
                                                      // BoxDecoration
                                                      // BorderRadius
                                                      // BoxShadow
                                                      // Border
                                                      // LinearGradient
                                                      // Alignment
                                                      // Offset
                                                      // Stack
                                                      // Positioned
                                                      // AnimatedContainer
                                                      // Curves
                                                      // Duration
                                                      // ClipRRect
                                                      // LinearProgressIndicator
                                                      // AlwaysStoppedAnimation
                                                      // GestureDetector
                                                      // Dialog
                                                      // showDialog
                                                      // Navigator
                                                      // ElevatedButton
                                                      // RefreshIndicator
                                                      // BouncingScrollPhysics
                                                      // AlwaysScrollableScrollPhysics
                                                      // NeverScrollableScrollPhysics
                                                      // SliverGridDelegateWithFixedCrossAxisCount
                                                      // BoxShape
                                                      // TextButton
                                                      // SingleChildScrollView

import 'package:flutter_bloc/flutter_bloc.dart';     // BlocBuilder
                                                      // context.read<T>()

import 'package:go_router/go_router.dart';           // context.push()

import 'package:intl/intl.dart';                     // DateFormat
                                                      // .format()

import 'package:share_plus/share_plus.dart';         // Share
                                                      // .share()

// Blocs
import '../../blocs/stats/stats_bloc.dart';          // StatsBloc
                                                      // StatsState
                                                      // StatsLoading
                                                      // StatsLoaded
                                                      // StatsError
                                                      // LoadStats

// Domain - Models
import '../../../domain/models/reading_stats.dart';  // ReadingStats
                                                      // .currentStreak
                                                      // .bestStreak
                                                      // .weeklyActivity
                                                      // .totalBooksRead
                                                      // .totalMinutesRead
                                                      // .totalPagesRead
                                                      // .avgPagesPerHour
                                                      // .avgMinutesPerDay
                                                      // .avgDaysPerBook
                                                      // .dailyMinutes
                                                      // .dailyGoalMinutes
                                                      // .monthlyData
                                                      // .monthlyBooks
                                                      // .genreBreakdown
                                                      // .genreDistribution
                                                      // .achievements
                                                      // .unlockedAchievements
                                                      // .totalAchievements
                                                      // .averageRating
                                                      // .booksReadThisYear
                                                      // .yearlyGoal
                                                      // .avgSessionMinutes
                                                      // .avgPagesPerDay
                                                      // .readingDays

import '../../../domain/models/achievement.dart';    // Achievement
                                                      // .isUnlocked
                                                      // .emoji
                                                      // .title
                                                      // .description
                                                      // .progress
                                                      // .unlockedAt

import '../../../domain/models/day_activity.dart';   // DayActivity
                                                      // .minutesRead

// Core
import '../../../core/theme/app_colors.dart';        // AppColors
                                                      // .primary

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class ReadingStatsScreen extends StatelessWidget {
  const ReadingStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Reading Stats',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () => _shareStats(context),
          ),
        ],
      ),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StatsError) {
            return _buildErrorState(
              context,
              state.message,
            );
          }
          if (state is! StatsLoaded) {
            return const Center(
              child: Text('Unable to load stats'),
            );
          }

          final stats = state.stats;

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<StatsBloc>()
                  .add(LoadStats());
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(
                parent:
                    AlwaysScrollableScrollPhysics(),
              ),
              children: [
                // ===== OVERVIEW CARDS =====
                _OverviewSection(stats: stats),
                const SizedBox(height: 24),

                // ===== STREAK CARD =====
                _StreakCard(stats: stats),
                const SizedBox(height: 24),

                // ===== YEARLY GOAL =====
                _YearlyGoalCard(stats: stats),
                const SizedBox(height: 24),

                // ===== QUICK STATS =====
                _QuickStatsGrid(stats: stats),
                const SizedBox(height: 28),

                // ===== WEEKLY CHART =====
                _SectionHeader(
                  title: 'This Week',
                  subtitle: 'Minutes read per day',
                ),
                const SizedBox(height: 16),
                _WeeklyChart(
                  dailyMinutes: stats.dailyMinutes,
                  dailyGoal: stats.dailyGoalMinutes,
                ),
                const SizedBox(height: 28),

                // ===== MONTHLY CHART =====
                _MonthlyReadingChart(stats: stats),
                const SizedBox(height: 24),

                // ===== MONTHLY HEATMAP =====
                _SectionHeader(
                  title: 'Monthly Activity',
                  subtitle: 'Your reading consistency',
                ),
                const SizedBox(height: 16),
                _MonthlyHeatmap(
                  monthlyData: stats.monthlyData,
                ),
                const SizedBox(height: 28),

                // ===== GENRE BREAKDOWN =====
                _SectionHeader(
                  title: 'Genre Breakdown',
                  subtitle: 'What you love reading',
                ),
                const SizedBox(height: 16),
                _GenreBreakdown(
                  genres: stats.genreBreakdown,
                ),
                const SizedBox(height: 24),

                // ===== GENRE DISTRIBUTION =====
                _GenreDistributionCard(
                  stats: stats,
                ),
                const SizedBox(height: 28),

                // ===== READING PACE =====
                _SectionHeader(
                  title: 'Reading Pace',
                  subtitle:
                      'Your reading speed over time',
                ),
                const SizedBox(height: 16),
                _ReadingPaceCard(stats: stats),
                const SizedBox(height: 24),

                // ===== READING TIME =====
                _ReadingTimeCard(stats: stats),
                const SizedBox(height: 28),

                // ===== ACHIEVEMENTS SECTION =====
                _AchievementsSection(
                  achievements: stats.achievements,
                ),
                const SizedBox(height: 24),

                // ===== ACHIEVEMENTS GRID =====
                _SectionHeader(
                  title: 'Achievements',
                  subtitle:
                      '${stats.unlockedAchievements}'
                      '/${stats.totalAchievements}'
                      ' unlocked',
                ),
                const SizedBox(height: 16),
                _AchievementsGrid(
                  achievements: stats.achievements,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String message,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 56,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => context
                .read<StatsBloc>()
                .add(LoadStats()),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareStats(BuildContext context) {
    final state =
        context.read<StatsBloc>().state;
    if (state is StatsLoaded) {
      final stats = state.stats;
      final text = '''
📚 My BookNest Reading Stats

🔥 ${stats.currentStreak} Day Streak
📖 ${stats.totalBooksRead} Books Read
⏱️ ${_formatMinutes(stats.totalMinutesRead)} Total Reading Time
📄 ${stats.totalPagesRead} Pages Read

Reading with BookNest 📱
''';
      Share.share(text);
    }
  }

  String _formatMinutes(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours < 24) return '${hours}h ${mins}m';
    final days = hours ~/ 24;
    return '${days}d ${hours % 24}h';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// OVERVIEW SECTION                              // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _OverviewSection extends StatelessWidget {
  final ReadingStats stats;
  const _OverviewSection({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.auto_stories_rounded,
                iconColor: Colors.blue,
                value: '${stats.totalBooksRead}',
                label: 'Books Read',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.timer_rounded,
                iconColor: Colors.green,
                value: _formatHours(
                  stats.totalMinutesRead,
                ),
                label: 'Hours Read',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.description_rounded,
                iconColor: Colors.orange,
                value: '${stats.totalPagesRead}',
                label: 'Pages Read',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.star_rounded,
                iconColor: Colors.amber,
                value: stats.averageRating
                    .toStringAsFixed(1),
                label: 'Avg Rating',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatHours(int minutes) {
    final hours = minutes ~/ 60;
    if (hours < 1) return '${minutes}m';
    return '${hours}h';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STAT CARD                                     // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STREAK CARD
// ─────────────────────────────────────────────────────────────────────────────

class _StreakCard extends StatelessWidget {
  final ReadingStats stats;
  const _StreakCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade400,
            Colors.deepOrange.shade500,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with best streak badge
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🔥 Reading Streak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  'Best: ${stats.bestStreak} days',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Streak count
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.currentStreak}',
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'days',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Last 7 days using readingDays
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final date = DateTime.now().subtract(
                Duration(days: 6 - index),
              );
              final didRead =
                  stats.readingDays.contains(
                _dateKey(date),
              );
              final isToday = index == 6;

              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: didRead
                          ? Colors.white
                          : Colors.white
                              .withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: Colors.white,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Icon(
                      didRead
                          ? Icons.check_rounded
                          : Icons.remove_rounded,
                      color: didRead
                          ? Colors.orange.shade600
                          : Colors.white38,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dayLabel(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),

          // Weekly activity dots (weeklyActivity)
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final dayLabels = [
                'M', 'T', 'W', 'T', 'F', 'S', 'S',
              ];
              final isActive = index <
                      stats.weeklyActivity.length &&
                  stats.weeklyActivity[index];
              final isToday =
                  index == DateTime.now().weekday - 1;

              return Column(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white
                          : Colors.white
                              .withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: Colors.white,
                              width: 2.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: isActive
                          ? Icon(
                              Icons.check_rounded,
                              color: Colors
                                  .orange.shade600,
                              size: 16,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dayLabels[index],
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(
                        isToday ? 1.0 : 0.7,
                      ),
                      fontSize: 10,
                      fontWeight: isToday
                          ? FontWeight.w800
                          : FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  String _dateKey(DateTime date) =>
      '${date.year}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  String _dayLabel(DateTime date) {
    const days = [
      'Mon', 'Tue', 'Wed',
      'Thu', 'Fri', 'Sat', 'Sun',
    ];
    return days[date.weekday - 1];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// YEARLY GOAL CARD                              // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _YearlyGoalCard extends StatelessWidget {
  final ReadingStats stats;
  const _YearlyGoalCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final progress = stats.yearlyGoal > 0
        ? (stats.booksReadThisYear / stats.yearlyGoal)
            .clamp(0.0, 1.0)
        : 0.0;
    final remaining =
        (stats.yearlyGoal - stats.booksReadThisYear)
            .clamp(0, stats.yearlyGoal);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '📚 Yearly Goal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${stats.booksReadThisYear}'
                ' / ${stats.yearlyGoal}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation(
                progress >= 1.0
                    ? Colors.green
                    : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toInt()}% complete',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                progress >= 1.0
                    ? '🎉 Goal reached!'
                    : '$remaining books to go',
                style: TextStyle(
                  fontSize: 13,
                  color: progress >= 1.0
                      ? Colors.green
                      : Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QUICK STATS GRID
// ─────────────────────────────────────────────────────────────────────────────

class _QuickStatsGrid extends StatelessWidget {
  final ReadingStats stats;
  const _QuickStatsGrid({required this.stats});

  String _formatMinutes(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _QuickStatCard(
          icon: Icons.menu_book_rounded,
          iconColor: Colors.blue,
          value: '${stats.totalBooksRead}',
          label: 'Books Read',
        ),
        _QuickStatCard(
          icon: Icons.timer_rounded,
          iconColor: Colors.green,
          value: _formatMinutes(
            stats.totalMinutesRead,
          ),
          label: 'Total Time',
        ),
        _QuickStatCard(
          icon: Icons.description_rounded,
          iconColor: Colors.purple,
          value: '${stats.totalPagesRead}',
          label: 'Pages Read',
        ),
        _QuickStatCard(
          icon: Icons.speed_rounded,
          iconColor: Colors.orange,
          value: '${stats.avgPagesPerHour}',
          label: 'Pages/Hour',
        ),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _QuickStatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WEEKLY CHART
// ─────────────────────────────────────────────────────────────────────────────

class _WeeklyChart extends StatelessWidget {
  final List<int> dailyMinutes;
  final int dailyGoal;

  const _WeeklyChart({
    required this.dailyMinutes,
    required this.dailyGoal,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = [
      ...dailyMinutes,
      dailyGoal,
    ].reduce((a, b) => a > b ? a : b).toDouble();
    final dayLabels = [
      'Mon', 'Tue', 'Wed',
      'Thu', 'Fri', 'Sat', 'Sun',
    ];

    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Goal Line Label
          Row(
            children: [
              Container(
                width: 12,
                height: 2,
                color: Colors.red.shade300,
              ),
              const SizedBox(width: 6),
              Text(
                'Goal: ${dailyGoal}min',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.red.shade300,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Bars
          Expanded(
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final value =
                    index < dailyMinutes.length
                        ? dailyMinutes[index]
                        : 0;
                final barHeight = maxVal > 0
                    ? (value / maxVal) * 120
                    : 0.0;
                final goalHeight = maxVal > 0
                    ? (dailyGoal / maxVal) * 120
                    : 0.0;
                final metGoal = value >= dailyGoal;
                final isToday =
                    index ==
                    DateTime.now().weekday - 1;

                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        if (value > 0)
                          Text(
                            '${value}m',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.w700,
                              color: metGoal
                                  ? Colors
                                      .green.shade600
                                  : Colors
                                      .grey.shade500,
                            ),
                          ),
                        const SizedBox(height: 4),

                        SizedBox(
                          height: 130,
                          child: Stack(
                            alignment:
                                Alignment.bottomCenter,
                            children: [
                              // Goal Line
                              Positioned(
                                bottom: goalHeight,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 1.5,
                                  color: Colors
                                      .red.shade200,
                                ),
                              ),

                              // Bar
                              AnimatedContainer(
                                duration: Duration(
                                  milliseconds:
                                      500 + index * 80,
                                ),
                                curve:
                                    Curves.easeOutCubic,
                                height: barHeight,
                                decoration:
                                    BoxDecoration(
                                  gradient:
                                      LinearGradient(
                                    begin: Alignment
                                        .bottomCenter,
                                    end: Alignment
                                        .topCenter,
                                    colors: metGoal
                                        ? [
                                            Colors.green
                                                .shade400,
                                            Colors.green
                                                .shade300,
                                          ]
                                        : isToday
                                            ? [
                                                AppColors
                                                    .primary,
                                                AppColors
                                                    .primary
                                                    .withOpacity(
                                                        0.7),
                                              ]
                                            : [
                                                Colors.grey
                                                    .shade300,
                                                Colors.grey
                                                    .shade200,
                                              ],
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          dayLabels[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isToday
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: isToday
                                ? AppColors.primary
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MONTHLY READING CHART                         // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _MonthlyReadingChart extends StatelessWidget {
  final ReadingStats stats;
  const _MonthlyReadingChart({required this.stats});

  @override
  Widget build(BuildContext context) {
    final maxBooks = stats.monthlyBooks.values
        .fold<int>(0, (a, b) => a > b ? a : b)
        .clamp(1, 999);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Books Per Month',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                final month = index + 1;
                final count =
                    stats.monthlyBooks[month] ?? 0;
                final height = maxBooks > 0
                    ? (count / maxBooks * 120)
                        .clamp(4.0, 120.0)
                    : 4.0;
                final isCurrentMonth =
                    month == DateTime.now().month;

                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        if (count > 0)
                          Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight:
                                  FontWeight.w700,
                              color: isCurrentMonth
                                  ? AppColors.primary
                                  : Colors
                                      .grey.shade600,
                            ),
                          ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 600,
                          ),
                          curve: Curves.easeOutCubic,
                          height: height,
                          decoration: BoxDecoration(
                            color: isCurrentMonth
                                ? AppColors.primary
                                : count > 0
                                    ? AppColors.primary
                                        .withOpacity(0.3)
                                    : Colors
                                        .grey.shade100,
                            borderRadius:
                                BorderRadius.circular(
                              4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _monthLabel(month),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: isCurrentMonth
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isCurrentMonth
                                ? AppColors.primary
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _monthLabel(int month) {
    const labels = [
      'Jan', 'Feb', 'Mar', 'Apr',
      'May', 'Jun', 'Jul', 'Aug',
      'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return labels[month - 1];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MONTHLY HEATMAP
// ─────────────────────────────────────────────────────────────────────────────

class _MonthlyHeatmap extends StatelessWidget {
  final List<DayActivity> monthlyData;

  const _MonthlyHeatmap({
    required this.monthlyData,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth =
        DateTime(now.year, now.month + 1, 0).day;
    final firstDayWeekday =
        DateTime(now.year, now.month, 1).weekday;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat('MMMM yyyy').format(now),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              'M', 'T', 'W', 'T', 'F', 'S', 'S',
            ].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount:
                daysInMonth + firstDayWeekday - 1,
            itemBuilder: (context, index) {
              if (index < firstDayWeekday - 1) {
                return const SizedBox.shrink();
              }

              final day =
                  index - firstDayWeekday + 2;
              final isToday = day == now.day;
              final isFuture = day > now.day;

              int minutes = 0;
              if (day - 1 < monthlyData.length) {
                minutes =
                    monthlyData[day - 1].minutesRead;
              }

              return Container(
                decoration: BoxDecoration(
                  color: isFuture
                      ? Colors.grey.shade50
                      : _getHeatmapColor(minutes),
                  borderRadius:
                      BorderRadius.circular(6),
                  border: isToday
                      ? Border.all(
                          color: AppColors.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isToday
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isFuture
                          ? Colors.grey.shade300
                          : minutes > 30
                              ? Colors.white
                              : Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                'Less',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 8),
              ...[0, 10, 20, 40, 60].map(
                (minutes) => Container(
                  width: 16,
                  height: 16,
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getHeatmapColor(minutes),
                    borderRadius:
                        BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'More',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getHeatmapColor(int minutes) {
    if (minutes == 0) return Colors.grey.shade100;
    if (minutes < 10) return Colors.green.shade100;
    if (minutes < 20) return Colors.green.shade200;
    if (minutes < 40) return Colors.green.shade400;
    if (minutes < 60) return Colors.green.shade600;
    return Colors.green.shade800;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GENRE BREAKDOWN
// ─────────────────────────────────────────────────────────────────────────────

class _GenreBreakdown extends StatelessWidget {
  final Map<String, int> genres;

  const _GenreBreakdown({required this.genres});

  @override
  Widget build(BuildContext context) {
    final total = genres.values
        .fold<int>(0, (sum, val) => sum + val);
    final sortedEntries = genres.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.red,
      Colors.cyan,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: sortedEntries
                    .asMap()
                    .entries
                    .map((entry) {
                  final percentage = total > 0
                      ? entry.value.value / total
                      : 0.0;
                  final color = colors[
                      entry.key % colors.length];
                  return Expanded(
                    flex: (percentage * 100)
                        .round()
                        .clamp(1, 100),
                    child: Container(color: color),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          ...sortedEntries.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final genre = entry.value.key;
              final count = entry.value.value;
              final percentage =
                  total > 0 ? count / total : 0.0;
              final color =
                  colors[index % colors.length];

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 14,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        genre,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '$count book'
                      '${count != 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${(percentage * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: color,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GENRE DISTRIBUTION CARD                       // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _GenreDistributionCard extends StatelessWidget {
  final ReadingStats stats;
  const _GenreDistributionCard({
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    if (stats.genreDistribution.isEmpty) {
      return const SizedBox.shrink();
    }

    final sortedGenres =
        stats.genreDistribution.entries.toList()
          ..sort(
            (a, b) => b.value.compareTo(a.value),
          );
    final total = sortedGenres.fold<int>(
      0,
      (sum, e) => sum + e.value,
    );

    final genreColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎭 Favorite Genres',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 16,
              child: Row(
                children: List.generate(
                  sortedGenres.length.clamp(0, 5),
                  (index) {
                    final fraction =
                        sortedGenres[index].value /
                            total;
                    return Expanded(
                      flex: (fraction * 100)
                          .round()
                          .clamp(1, 100),
                      child: Container(
                        color: genreColors[
                            index % genreColors.length],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          ...List.generate(
            sortedGenres.length.clamp(0, 5),
            (index) {
              final entry = sortedGenres[index];
              final percentage =
                  ((entry.value / total) * 100)
                      .round();
              final color = genreColors[
                  index % genreColors.length];

              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '${entry.value} books',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// READING PACE CARD
// ─────────────────────────────────────────────────────────────────────────────

class _ReadingPaceCard extends StatelessWidget {
  final ReadingStats stats;

  const _ReadingPaceCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _PaceItem(
                icon: Icons.speed_rounded,
                color: Colors.blue,
                value: '${stats.avgPagesPerHour}',
                label: 'Pages/Hour',
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade200,
              ),
              _PaceItem(
                icon: Icons.calendar_today_rounded,
                color: Colors.green,
                value: '${stats.avgMinutesPerDay}',
                label: 'Min/Day',
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade200,
              ),
              _PaceItem(
                icon: Icons.book_rounded,
                color: Colors.purple,
                value: '${stats.avgDaysPerBook}',
                label: 'Days/Book',
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary
                  .withOpacity(0.06),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _getPaceMessage(stats),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPaceMessage(ReadingStats stats) {
    if (stats.avgMinutesPerDay >= 30) {
      return 'Amazing! You\'re reading above '
          'average. Keep it up! 🚀';
    } else if (stats.avgMinutesPerDay >= 15) {
      return 'Great job! You\'re building a solid '
          'reading habit. 💪';
    } else if (stats.avgMinutesPerDay >= 5) {
      return 'Good start! Try to read 15+ minutes '
          'daily for best results. 📈';
    } else {
      return 'Set a daily goal and start your '
          'reading journey today! ✨';
    }
  }
}

class _PaceItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _PaceItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// READING TIME CARD                             // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _ReadingTimeCard extends StatelessWidget {
  final ReadingStats stats;
  const _ReadingTimeCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final avgMinutes = stats.totalBooksRead > 0
        ? stats.totalMinutesRead ~/
            stats.totalBooksRead
        : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⏱️ Reading Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),

          _TimeRow(
            label: 'Total reading time',
            value: _formatTime(
              stats.totalMinutesRead,
            ),
            icon: Icons.access_time_filled_rounded,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _TimeRow(
            label: 'Avg. per book',
            value: _formatTime(avgMinutes),
            icon: Icons.menu_book_rounded,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _TimeRow(
            label: 'Avg. per session',
            value: _formatTime(
              stats.avgSessionMinutes,
            ),
            icon: Icons.timelapse_rounded,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _TimeRow(
            label: 'Avg. pages per day',
            value: '${stats.avgPagesPerDay} pages',
            icon: Icons.trending_up_rounded,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  String _formatTime(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '${hours}h';
    return '${hours}h ${mins}m';
  }
}

class _TimeRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _TimeRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENTS SECTION                          // ✅ ADDED from old version
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementsSection extends StatelessWidget {
  final List<Achievement> achievements;
  const _AchievementsSection({
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '🏆 Achievements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            TextButton(
              onPressed: () =>
                  context.push('/achievements'),
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics:
                const BouncingScrollPhysics(),
            itemCount:
                achievements.length.clamp(0, 10),
            separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _AchievementPreviewCard(
                achievement: achievements[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENT PREVIEW CARD                      // ✅ ADDED from old version
// Horizontal scroll card (used in _AchievementsSection)
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementPreviewCard extends StatelessWidget {
  final Achievement achievement;
  const _AchievementPreviewCard({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: achievement.isUnlocked
            ? Colors.amber.shade50
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achievement.isUnlocked
              ? Colors.amber.shade200
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            achievement.emoji,
            style: TextStyle(
              fontSize: 32,
              color: achievement.isUnlocked
                  ? null
                  : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: achievement.isUnlocked
                  ? Colors.black87
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENTS GRID
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementsGrid extends StatelessWidget {
  final List<Achievement> achievements;

  const _AchievementsGrid({
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return _AchievementCard(
          achievement: achievements[index],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENT CARD
// Grid card with detail dialog
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const _AchievementCard({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = achievement.isUnlocked;

    return GestureDetector(
      onTap: () =>
          _showAchievementDetail(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUnlocked
              ? Colors.white
              : Colors.grey.shade50,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked
                ? Colors.amber.shade300
                : Colors.grey.shade200,
            width: isUnlocked ? 2 : 1,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: Colors.amber
                        .withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            // Emoji
            Text(
              achievement.emoji,
              style: TextStyle(
                fontSize: 32,
                color: isUnlocked
                    ? null
                    : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              achievement.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: isUnlocked
                    ? Colors.black
                    : Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Progress or Unlock Date
            if (isUnlocked)
              Text(
                DateFormat('MMM d').format(
                  achievement.unlockedAt!,
                ),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              )
            else
              Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: achievement.progress,
                      backgroundColor:
                          Colors.grey.shade200,
                      valueColor:
                          AlwaysStoppedAnimation<
                              Color>(
                        Colors.amber.shade400,
                      ),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${(achievement.progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showAchievementDetail(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Large emoji
              Text(
                achievement.emoji,
                style: const TextStyle(
                  fontSize: 64,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                achievement.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                achievement.description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Status
              if (achievement.isUnlocked)
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color:
                            Colors.green.shade600,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Unlocked '
                        '${DateFormat('MMM d, yyyy').format(achievement.unlockedAt!)}',
                        style: TextStyle(
                          color:
                              Colors.green.shade700,
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(6),
                      child:
                          LinearProgressIndicator(
                        value: achievement.progress,
                        backgroundColor:
                            Colors.grey.shade200,
                        valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                          Colors.amber.shade400,
                        ),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(achievement.progress * 100).toInt()}% complete',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}