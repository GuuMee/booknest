// lib/presentation/screens/profile/tabs/statistics_tab.dart

import 'dart:math';                               // max()

import 'package:flutter/material.dart';           // StatelessWidget, Widget
                                                  // ListView, GridView
                                                  // Container, Column, Row
                                                  // CircularProgressIndicator
                                                  // AnimatedContainer
                                                  // BoxDecoration, LinearGradient
                                                  // Colors, Icons
import 'package:flutter_bloc/flutter_bloc.dart';  // BlocBuilder

// Presentation - BLoC - Stats
import '../../../bloc/stats/stats_bloc.dart';     // StatsBloc
import '../../../bloc/stats/stats_state.dart';    // StatsState, StatsLoading, StatsLoaded

// Data - Models
import '../../../../data/models/reading_stats.dart';    // ReadingStats
import '../../../../data/models/daily_reading.dart';    // DailyReading
import '../../../../data/models/genre_breakdown.dart';  // GenreBreakdown

// Core - Theme
import '../../../../core/theme/app_colors.dart';        // AppColors

// ─────────────────────────────────────────────────────────────────────────────
// TAB — StatisticsTab
// ─────────────────────────────────────────────────────────────────────────────

class _StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StatsLoaded) {
          return ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              // ===== DAILY GOAL =====
              _DailyGoalCard(stats: state.stats),
              const SizedBox(height: 20),

              // ===== READING STREAK =====
              _StreakCard(
                currentStreak: state.currentStreak,
                longestStreak: state.longestStreak,
              ),
              const SizedBox(height: 20),

              // ===== WEEKLY CHART =====
              _WeeklyChartCard(data: state.weeklyData),
              const SizedBox(height: 20),

              // ===== STATS GRID =====
              _StatsGrid(
                totalBooks: state.totalBooksRead,
                totalPages: state.totalPagesRead,
                totalMinutes: state.totalMinutesRead,
                avgPerDay: state.averageMinutesPerDay,
              ),
              const SizedBox(height: 20),

              // ===== GENRE BREAKDOWN =====
              _GenreBreakdownCard(genres: state.genreBreakdown),
              const SizedBox(height: 100),
            ],
          );
        }

        return const Center(child: Text('No stats yet'));
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _DailyGoalCard
// ─────────────────────────────────────────────────────────────────────────────

class _DailyGoalCard extends StatelessWidget {
  final ReadingStats stats;

  const _DailyGoalCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Goal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${stats.dailyGoalMinutes} min goal',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Circular progress
          Center(
            child: SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CircularProgressIndicator(
                      value: stats.todayProgress.clamp(0.0, 1.0),
                      strokeWidth: 10,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.white),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${stats.todayMinutes}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'minutes',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Motivation text
          Center(
            child: Text(
              stats.todayProgress >= 1.0
                  ? '🎉 Goal achieved! Keep going!'
                  : '${stats.dailyGoalMinutes - stats.todayMinutes}'
                      ' minutes left to reach your goal',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _StreakCard
// ─────────────────────────────────────────────────────────────────────────────

class _StreakCard extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;

  const _StreakCard({
    required this.currentStreak,
    required this.longestStreak,
  });

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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('🔥', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$currentStreak Day Streak',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Longest: $longestStreak days',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              if (currentStreak >= longestStreak && currentStreak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '🏆 Best!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Week dots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
              final today = DateTime.now().weekday - 1;
              final isToday = index == today;
              final isPast = index < today;
              final isActive = isPast || isToday;

              return Column(
                children: [
                  Text(
                    dayNames[index],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange.shade400
                          : Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: Colors.orange.shade600,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: isActive
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
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
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _WeeklyChartCard
// ─────────────────────────────────────────────────────────────────────────────

class _WeeklyChartCard extends StatelessWidget {
  final List<DailyReading> data;

  const _WeeklyChartCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final maxMinutes = data.isEmpty
        ? 60.0
        : data
            .map((d) => d.minutesRead)
            .reduce(max)
            .toDouble()
            .clamp(30, 300);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This Week',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${data.fold(0, (sum, d) => sum + d.minutesRead)}'
                ' min total',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Bar chart
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final dayData =
                    index < data.length ? data[index] : null;
                final minutes = dayData?.minutesRead ?? 0;
                final barHeight = maxMinutes > 0
                    ? (minutes / maxMinutes * 130).clamp(4.0, 130.0)
                    : 4.0;
                final isToday =
                    index == DateTime.now().weekday - 1;
                final dayNames = [
                  'Mon', 'Tue', 'Wed',
                  'Thu', 'Fri', 'Sat', 'Sun',
                ];

                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Minutes label
                        if (minutes > 0)
                          Text(
                            '${minutes}m',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isToday
                                  ? AppColors.primary
                                  : Colors.grey.shade500,
                            ),
                          ),
                        const SizedBox(height: 4),

                        // Bar
                        AnimatedContainer(
                          duration: Duration(
                            milliseconds: 300 + index * 100,
                          ),
                          curve: Curves.easeOutCubic,
                          height: barHeight,
                          decoration: BoxDecoration(
                            gradient: isToday
                                ? LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primary.shade300,
                                    ],
                                  )
                                : null,
                            color: isToday
                                ? null
                                : minutes > 0
                                    ? AppColors.primary
                                        .withOpacity(0.3)
                                    : Colors.grey.shade200,
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Day label
                        Text(
                          dayNames[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isToday
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: isToday
                                ? AppColors.primary
                                : Colors.grey.shade400,
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
// WIDGET — _StatsGrid
// ─────────────────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  final int totalBooks;
  final int totalPages;
  final int totalMinutes;
  final double avgPerDay;

  const _StatsGrid({
    required this.totalBooks,
    required this.totalPages,
    required this.totalMinutes,
    required this.avgPerDay,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          icon: Icons.menu_book_rounded,
          iconColor: Colors.blue,
          iconBgColor: Colors.blue.shade50,
          value: '$totalBooks',
          label: 'Books Read',
        ),
        _StatCard(
          icon: Icons.description_rounded,
          iconColor: Colors.green,
          iconBgColor: Colors.green.shade50,
          value: _formatNumber(totalPages),
          label: 'Pages Read',
        ),
        _StatCard(
          icon: Icons.timer_rounded,
          iconColor: Colors.purple,
          iconBgColor: Colors.purple.shade50,
          value: '${(totalMinutes / 60).round()}h',
          label: 'Total Time',
        ),
        _StatCard(
          icon: Icons.trending_up_rounded,
          iconColor: Colors.orange,
          iconBgColor: Colors.orange.shade50,
          value: '${avgPerDay.round()}m',
          label: 'Avg/Day',
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return '$number';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _StatCard
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
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
// WIDGET — _GenreBreakdownCard
// ─────────────────────────────────────────────────────────────────────────────

class _GenreBreakdownCard extends StatelessWidget {
  final List<GenreBreakdown> genres;

  const _GenreBreakdownCard({required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Genre Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),

          // Horizontal bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 12,
              child: Row(
                children: genres.map((genre) {
                  return Expanded(
                    flex: (genre.percentage * 100)
                        .round()
                        .clamp(1, 100),
                    child: Container(color: genre.color),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Legend
          ...genres.take(6).map((genre) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: genre.color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      genre.genre,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${genre.bookCount} books',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${(genre.percentage * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}