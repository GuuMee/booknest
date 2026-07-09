// lib/data/models/user_model.dart

import './subscription_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String userType;            // "adult" or "kid"
  final String? parentId;           // If kid, reference to parent
  final List<String> kidProfiles;   // If parent, list of kid IDs
  final SubscriptionModel? subscription;
  final ReadingPreferences preferences;
  final ReadingStats stats;
  final DateTime createdAt;
  final DateTime lastActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.userType = 'adult',
    this.parentId,
    this.kidProfiles = const [],
    this.subscription,
    required this.preferences,
    required this.stats,
    required this.createdAt,
    required this.lastActive,
  });
}

class ReadingPreferences {
  final String readerTheme;        // "light", "sepia", "dark"
  final double brightness;
  final String scrollDirection;    // "vertical", "horizontal"
  final bool keepScreenOn;
  final bool autoBookmark;

  ReadingPreferences({
    this.readerTheme = 'light',
    this.brightness = 1.0,
    this.scrollDirection = 'vertical',
    this.keepScreenOn = true,
    this.autoBookmark = true,
  });
}

class ReadingStats {
  final int totalBooksRead;
  final int totalPagesRead;
  final int totalMinutesRead;
  final int currentStreak;
  final int longestStreak;
  final int booksThisMonth;
  final List<String> achievements;

  ReadingStats({
    this.totalBooksRead = 0,
    this.totalPagesRead = 0,
    this.totalMinutesRead = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.booksThisMonth = 0,
    this.achievements = const [],
  });
}