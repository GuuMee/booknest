// lib/presentation/screens/profile/tabs/achievements_tab.dart

import 'package:flutter/material.dart';           // StatelessWidget, Widget
                                                  // ListView, Container, Row, Column
                                                  // LinearProgressIndicator
                                                  // ClipRRect, BoxDecoration
                                                  // LinearGradient, Colors, Icons
import 'package:flutter_bloc/flutter_bloc.dart';  // BlocBuilder

// Presentation - BLoC - Stats
import '../../../bloc/stats/stats_bloc.dart';     // StatsBloc
import '../../../bloc/stats/stats_state.dart';    // StatsState, StatsLoaded

// Data - Models
import '../../../../data/models/achievement.dart'; // Achievement

// Core - Theme
import '../../../../core/theme/app_colors.dart';  // AppColors

// ─────────────────────────────────────────────────────────────────────────────
// TAB — AchievementsTab
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is! StatsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final achievements = state.achievements;
        final unlocked = achievements.where((a) => a.isUnlocked).toList();
        final locked = achievements.where((a) => !a.isUnlocked).toList();

        return ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Progress overview
            _AchievementProgress(
              total: achievements.length,
              unlocked: unlocked.length,
            ),
            const SizedBox(height: 20),

            // Unlocked
            if (unlocked.isNotEmpty) ...[
              _SectionTitle(
                title: 'Unlocked',
                trailing: '${unlocked.length}',
              ),
              const SizedBox(height: 12),
              ...unlocked.map((a) => _AchievementCard(
                    achievement: a,
                    isUnlocked: true,
                  )),
              const SizedBox(height: 24),
            ],

            // In Progress
            _SectionTitle(
              title: 'In Progress',
              trailing: '${locked.length}',
            ),
            const SizedBox(height: 12),
            ...locked.map((a) => _AchievementCard(
                  achievement: a,
                  isUnlocked: false,
                )),
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _AchievementProgress
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementProgress extends StatelessWidget {
  final int total;
  final int unlocked;

  const _AchievementProgress({
    required this.total,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? unlocked / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade400,
            Colors.orange.shade500,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Trophy
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('🏆', style: TextStyle(fontSize: 30)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$unlocked / $total Achievements',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation(Colors.white),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(progress * 100).round()}% complete',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _AchievementCard
// ─────────────────────────────────────────────────────────────────────────────

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool isUnlocked;

  const _AchievementCard({
    required this.achievement,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? Colors.amber.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUnlocked
            ? Border.all(color: Colors.amber.shade200, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? Colors.amber.shade100
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                achievement.icon,
                style: TextStyle(
                  fontSize: 24,
                  color: isUnlocked ? null : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      achievement.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isUnlocked
                            ? Colors.amber.shade900
                            : Colors.black87,
                      ),
                    ),
                    if (isUnlocked) ...[
                      const SizedBox(width: 6),
                      Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: Colors.amber.shade600,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                if (!isUnlocked && achievement.target > 0) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: achievement.progress
                                .clamp(0.0, 1.0),
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.primary.withOpacity(0.7),
                            ),
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${achievement.current}/${achievement.target}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (isUnlocked && achievement.unlockedAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Unlocked ${_formatDate(achievement.unlockedAt!)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'today';
    if (diff.inDays == 1) return 'yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) return '${diff.inDays ~/ 7} weeks ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _SectionTitle
// ─────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const _SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (trailing != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              trailing!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }
}