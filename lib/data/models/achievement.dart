// lib/data/models/achievement.dart

import 'package:equatable/equatable.dart';        // Equatable
                                                   // .props

// ─────────────────────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────────────────────

class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double progress; // 0.0 to 1.0
  final int target;
  final int current;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0.0,
    this.target = 0,
    this.current = 0,
  });

  factory Achievement.fromJson(
    Map<String, dynamic> json,
  ) {
    return Achievement(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '🏆',
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'])
          : null,
      progress:
          (json['progress'] ?? 0.0).toDouble(),
      target: json['target'] ?? 0,
      current: json['current'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'icon': icon,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
        'progress': progress,
        'target': target,
        'current': current,
      };

  @override
  List<Object?> get props => [
        id,
        isUnlocked,
        progress,
      ];
}

// ─────────────────────────────────────────────────────────────────────────────
// PREDEFINED ACHIEVEMENTS
// ─────────────────────────────────────────────────────────────────────────────

class AchievementDefinitions {
  static List<Achievement> all() => [
        const Achievement(
          id: 'first_book',
          title: 'First Steps',
          description: 'Finish your first book',
          icon: '📖',
          target: 1,
        ),
        const Achievement(
          id: 'bookworm',
          title: 'Bookworm',
          description: 'Read 10 books',
          icon: '🐛',
          target: 10,
        ),
        const Achievement(
          id: 'library_builder',
          title: 'Library Builder',
          description: 'Read 25 books',
          icon: '🏛️',
          target: 25,
        ),
        const Achievement(
          id: 'century_reader',
          title: 'Century Reader',
          description: 'Read 100 books',
          icon: '💯',
          target: 100,
        ),
        const Achievement(
          id: 'streak_7',
          title: 'Week Warrior',
          description: 'Read for 7 days in a row',
          icon: '🔥',
          target: 7,
        ),
        const Achievement(
          id: 'streak_30',
          title: 'Monthly Master',
          description: 'Read for 30 days in a row',
          icon: '⚡',
          target: 30,
        ),
        const Achievement(
          id: 'streak_100',
          title: 'Unstoppable',
          description:
              'Read for 100 days in a row',
          icon: '🌟',
          target: 100,
        ),
        const Achievement(
          id: 'genre_explorer',
          title: 'Genre Explorer',
          description:
              'Read books from 5 different genres',
          icon: '🗺️',
          target: 5,
        ),
        const Achievement(
          id: 'night_owl',
          title: 'Night Owl',
          description:
              'Read after midnight 10 times',
          icon: '🦉',
          target: 10,
        ),
        const Achievement(
          id: 'speed_reader',
          title: 'Speed Reader',
          description:
              'Read 500 pages in a single day',
          icon: '⚡',
          target: 500,
        ),
        const Achievement(
          id: 'reviewer',
          title: 'Critic',
          description: 'Write 10 book reviews',
          icon: '✍️',
          target: 10,
        ),
        const Achievement(
          id: 'page_turner',
          title: 'Page Turner',
          description: 'Read 10,000 pages total',
          icon: '📄',
          target: 10000,
        ),
        const Achievement(
          id: 'marathon',
          title: 'Reading Marathon',
          description: 'Read for 2 hours straight',
          icon: '🏃',
          target: 120,
        ),
        const Achievement(
          id: 'yearly_goal',
          title: 'Goal Crusher',
          description:
              'Complete your yearly reading goal',
          icon: '🎯',
          target: 1,
        ),
      ];
}