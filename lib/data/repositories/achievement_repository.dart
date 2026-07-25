// lib/data/repositories/achievement_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';  // FirebaseFirestore
                                                         // SetOptions
import 'package:firebase_auth/firebase_auth.dart';       // FirebaseAuth
import 'package:flutter/foundation.dart';                // debugPrint
import 'package:hive/hive.dart';                         // Box<dynamic>

import '../models/achievement.dart';                     // Achievement
                                                         // AchievementCategory
import 'stats_repository.dart';                          // StatsRepository

// lib/data/repositories/achievement_repository.dart

class AchievementRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Box<dynamic> _localBox;
  final StatsRepository _statsRepository;

  AchievementRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required Box<dynamic> localBox,
    required StatsRepository statsRepository,
  })  : _firestore = firestore,
        _auth = auth,
        _localBox = localBox,
        _statsRepository = statsRepository;

  String get _userId => _auth.currentUser?.uid ?? 'anonymous';

  // ===== PREDEFINED ACHIEVEMENTS =====
  static final List<Achievement> _allAchievements = [
    // Reading
    const Achievement(
      id: 'first_book',
      title: 'First Chapter',
      description: 'Read your first book',
      icon: '📖',
      isUnlocked: false,
      progress: 0,
      target: 1,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'bookworm',
      title: 'Bookworm',
      description: 'Read 10 books',
      icon: '🐛',
      isUnlocked: false,
      progress: 0,
      target: 10,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'bibliophile',
      title: 'Bibliophile',
      description: 'Read 50 books',
      icon: '📚',
      isUnlocked: false,
      progress: 0,
      target: 50,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'page_turner',
      title: 'Page Turner',
      description: 'Read 1,000 pages',
      icon: '📄',
      isUnlocked: false,
      progress: 0,
      target: 1000,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'marathon_reader',
      title: 'Marathon Reader',
      description: 'Read for 60 minutes in one session',
      icon: '🏃',
      isUnlocked: false,
      progress: 0,
      target: 60,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'night_owl',
      title: 'Night Owl',
      description: 'Read after midnight',
      icon: '🦉',
      isUnlocked: false,
      progress: 0,
      target: 1,
      current: 0,
      category: AchievementCategory.reading,
    ),
    const Achievement(
      id: 'early_bird',
      title: 'Early Bird',
      description: 'Read before 6 AM',
      icon: '🐦',
      isUnlocked: false,
      progress: 0,
      target: 1,
      current: 0,
      category: AchievementCategory.reading,
    ),

    // Streaks
    const Achievement(
      id: 'streak_3',
      title: 'Getting Started',
      description: '3-day reading streak',
      icon: '🔥',
      isUnlocked: false,
      progress: 0,
      target: 3,
      current: 0,
      category: AchievementCategory.streak,
    ),
    const Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: '7-day reading streak',
      icon: '⚡',
      isUnlocked: false,
      progress: 0,
      target: 7,
      current: 0,
      category: AchievementCategory.streak,
    ),
    const Achievement(
      id: 'streak_30',
      title: 'Unstoppable',
      description: '30-day reading streak',
      icon: '💎',
      isUnlocked: false,
      progress: 0,
      target: 30,
      current: 0,
      category: AchievementCategory.streak,
    ),
    const Achievement(
      id: 'streak_100',
      title: 'Legendary',
      description: '100-day reading streak',
      icon: '👑',
      isUnlocked: false,
      progress: 0,
      target: 100,
      current: 0,
      category: AchievementCategory.streak,
    ),

    // Explorer
    const Achievement(
      id: 'genre_explorer',
      title: 'Genre Explorer',
      description: 'Read books from 5 different genres',
      icon: '🧭',
      isUnlocked: false,
      progress: 0,
      target: 5,
      current: 0,
      category: AchievementCategory.explorer,
    ),
    const Achievement(
      id: 'world_traveler',
      title: 'World Traveler',
      description: 'Read books from 10 different genres',
      icon: '🌍',
      isUnlocked: false,
      progress: 0,
      target: 10,
      current: 0,
      category: AchievementCategory.explorer,
    ),

    // Collection
    const Achievement(
      id: 'collector',
      title: 'Collector',
      description: 'Add 20 books to your library',
      icon: '🗂️',
      isUnlocked: false,
      progress: 0,
      target: 20,
      current: 0,
      category: AchievementCategory.collection,
    ),
    const Achievement(
      id: 'bookmarker',
      title: 'Bookmarker',
      description: 'Create 50 bookmarks',
      icon: '🔖',
      isUnlocked: false,
      progress: 0,
      target: 50,
      current: 0,
      category: AchievementCategory.collection,
    ),

    // Social
    const Achievement(
      id: 'reviewer',
      title: 'Critic',
      description: 'Write 10 book reviews',
      icon: '✍️',
      isUnlocked: false,
      progress: 0,
      target: 10,
      current: 0,
      category: AchievementCategory.social,
    ),
    const Achievement(
      id: 'sharer',
      title: 'Sharing is Caring',
      description: 'Share 5 books with friends',
      icon: '🤝',
      isUnlocked: false,
      progress: 0,
      target: 5,
      current: 0,
      category: AchievementCategory.social,
    ),
  ];

  // ===== GET ACHIEVEMENTS =====
  Future<List<Achievement>> getAchievements() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('achievements')
          .get();

      final userAchievements = <String, Map<String, dynamic>>{};
      for (final doc in snapshot.docs) {
        userAchievements[doc.id] = doc.data();
      }

      return _allAchievements.map((achievement) {
        final userData = userAchievements[achievement.id];
        if (userData != null) {
          return achievement.copyWith(
            isUnlocked: userData['isUnlocked'] ?? false,
            unlockedAt: userData['unlockedAt'] != null
                ? DateTime.parse(userData['unlockedAt'])
                : null,
            current: userData['current'] ?? 0,
            progress: userData['current'] != null
                ? (userData['current'] / achievement.target)
                    .clamp(0.0, 1.0)
                : 0.0,
          );
        }
        return achievement;
      }).toList();
    } catch (_) {
      return _allAchievements;
    }
  }

  // ===== CHECK AND UNLOCK =====
  Future<List<Achievement>> checkAndUnlockAchievements({
    int? durationSeconds,
    int? pagesRead,
  }) async {
    final newlyUnlocked = <Achievement>[];

    try {
      final stats = await _statsRepository.getReadingStats();
      final streak = await _statsRepository.getCurrentStreak();
      final genreCount = await _statsRepository.getUniqueGenreCount();
      final achievements = await getAchievements();

      for (final achievement in achievements) {
        if (achievement.isUnlocked) continue;

        int currentValue = 0;
        bool shouldUnlock = false;

        switch (achievement.id) {
          // Reading achievements
          case 'first_book':
            currentValue = stats.totalBooksRead;
            shouldUnlock = currentValue >= achievement.target;
            break;
          case 'bookworm':
            currentValue = stats.totalBooksRead;
            shouldUnlock = currentValue >= achievement.target;
            break;
          case 'bibliophile':
            currentValue = stats.totalBooksRead;
            shouldUnlock = currentValue >= achievement.target;
            break;
          case 'page_turner':
            currentValue = stats.totalPagesRead;
            shouldUnlock = currentValue >= achievement.target;
            break;
          case 'marathon_reader':
            if (durationSeconds != null) {
              currentValue = durationSeconds ~/ 60;
              shouldUnlock = currentValue >= achievement.target;
            }
            break;
          case 'night_owl':
            final hour = DateTime.now().hour;
            shouldUnlock = hour >= 0 && hour < 4;
            currentValue = shouldUnlock ? 1 : 0;
            break;
          case 'early_bird':
            final hour = DateTime.now().hour;
            shouldUnlock = hour >= 4 && hour < 6;
            currentValue = shouldUnlock ? 1 : 0;
            break;

          // Streak achievements
          case 'streak_3':
          case 'streak_7':
          case 'streak_30':
          case 'streak_100':
            currentValue = streak;
            shouldUnlock = currentValue >= achievement.target;
            break;

          // Explorer
          case 'genre_explorer':
          case 'world_traveler':
            currentValue = genreCount;
            shouldUnlock = currentValue >= achievement.target;
            break;
        }

        // Update progress
        await _updateAchievementProgress(
          achievement.id,
          currentValue,
          shouldUnlock,
        );

        if (shouldUnlock) {
          newlyUnlocked.add(achievement.copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
            current: currentValue,
            progress: 1.0,
          ));
        }
      }
    } catch (e) {
      debugPrint('Achievement check error: $e');
    }

    return newlyUnlocked;
  }

  Future<void> _updateAchievementProgress(
    String achievementId,
    int current,
    bool isUnlocked,
  ) async {
    final data = <String, dynamic>{
      'current': current,
    };

    if (isUnlocked) {
      data['isUnlocked'] = true;
      data['unlockedAt'] = DateTime.now().toIso8601String();
    }

    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('achievements')
          .doc(achievementId)
          .set(data, SetOptions(merge: true));
    } catch (_) {}
  }
}