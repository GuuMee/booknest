// lib/data/models/app_settings.dart

import 'package:equatable/equatable.dart';                        // Equatable
import 'package:flutter/material.dart';                           // ThemeMode
                                                                  // ThemeMode.system
                                                                  // ThemeMode.values
                                                                  // ThemeMode.index
                                                                  // TimeOfDay
                                                                  // Color
                                                                  // Color.value
                                                                  // Colors.blue
                                                                  // Colors.blue.value

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — AppSettings
// ─────────────────────────────────────────────────────────────────────────────

class AppSettings extends Equatable {
  // ─────────────────────────────────────────
  // FIELDS
  // ─────────────────────────────────────────

  // Reading
  final double fontSize;
  final double lineSpacing;
  final String readingTheme;
  final bool keepScreenOn;
  final bool autoRotate;
  final bool tapToTurnPages;
  final bool volumeButtonPageTurn;
  final bool enableAnimations;

  // Goals
  final int dailyGoalMinutes;
  final int yearlyBookGoal;

  // Notifications & Reminders
  final bool pushNotifications;
  final bool readingReminders;
  final bool dailyReminderEnabled;
  final bool streakReminder;
  final TimeOfDay reminderTime;
  final int reminderHour;
  final int reminderMinute;

  // Appearance
  final ThemeMode themeMode;
  final String appTheme;
  final Color accentColor;

  // Storage & Data
  final bool downloadOnWifiOnly;
  final bool wifiOnlyDownload;
  final DateTime? lastSyncTime;

  // ─────────────────────────────────────────
  // CONSTRUCTOR
  // ─────────────────────────────────────────

  const AppSettings({
    // Reading
    this.fontSize = 16.0,
    this.lineSpacing = 1.5,
    this.readingTheme = 'light',
    this.keepScreenOn = true,
    this.autoRotate = false,
    this.tapToTurnPages = false,
    this.volumeButtonPageTurn = false,
    this.enableAnimations = true,
    // Goals
    this.dailyGoalMinutes = 30,
    this.yearlyBookGoal = 12,
    // Notifications & Reminders
    this.pushNotifications = true,
    this.readingReminders = false,
    this.dailyReminderEnabled = false,
    this.streakReminder = true,
    this.reminderTime = const TimeOfDay(hour: 20, minute: 0),
    this.reminderHour = 20,
    this.reminderMinute = 0,
    // Appearance
    this.themeMode = ThemeMode.system,
    this.appTheme = 'system',
    this.accentColor = Colors.blue,
    // Storage & Data
    this.downloadOnWifiOnly = true,
    this.wifiOnlyDownload = false,
    this.lastSyncTime,
  });

  // ─────────────────────────────────────────
  // COPY WITH
  // ─────────────────────────────────────────

  AppSettings copyWith({
    // Reading
    double? fontSize,
    double? lineSpacing,
    String? readingTheme,
    bool? keepScreenOn,
    bool? autoRotate,
    bool? tapToTurnPages,
    bool? volumeButtonPageTurn,
    bool? enableAnimations,
    // Goals
    int? dailyGoalMinutes,
    int? yearlyBookGoal,
    // Notifications & Reminders
    bool? pushNotifications,
    bool? readingReminders,
    bool? dailyReminderEnabled,
    bool? streakReminder,
    TimeOfDay? reminderTime,
    int? reminderHour,
    int? reminderMinute,
    // Appearance
    ThemeMode? themeMode,
    String? appTheme,
    Color? accentColor,
    // Storage & Data
    bool? downloadOnWifiOnly,
    bool? wifiOnlyDownload,
    DateTime? lastSyncTime,
  }) {
    return AppSettings(
      // Reading
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      readingTheme: readingTheme ?? this.readingTheme,
      keepScreenOn: keepScreenOn ?? this.keepScreenOn,
      autoRotate: autoRotate ?? this.autoRotate,
      tapToTurnPages:
          tapToTurnPages ?? this.tapToTurnPages,
      volumeButtonPageTurn:
          volumeButtonPageTurn ?? this.volumeButtonPageTurn,
      enableAnimations:
          enableAnimations ?? this.enableAnimations,
      // Goals
      dailyGoalMinutes:
          dailyGoalMinutes ?? this.dailyGoalMinutes,
      yearlyBookGoal:
          yearlyBookGoal ?? this.yearlyBookGoal,
      // Notifications & Reminders
      pushNotifications:
          pushNotifications ?? this.pushNotifications,
      readingReminders:
          readingReminders ?? this.readingReminders,
      dailyReminderEnabled:
          dailyReminderEnabled ?? this.dailyReminderEnabled,
      streakReminder:
          streakReminder ?? this.streakReminder,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute:
          reminderMinute ?? this.reminderMinute,
      // Appearance
      themeMode: themeMode ?? this.themeMode,
      appTheme: appTheme ?? this.appTheme,
      accentColor: accentColor ?? this.accentColor,
      // Storage & Data
      downloadOnWifiOnly:
          downloadOnWifiOnly ?? this.downloadOnWifiOnly,
      wifiOnlyDownload:
          wifiOnlyDownload ?? this.wifiOnlyDownload,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        // Reading
        'fontSize': fontSize,
        'lineSpacing': lineSpacing,
        'readingTheme': readingTheme,
        'keepScreenOn': keepScreenOn,
        'autoRotate': autoRotate,
        'tapToTurnPages': tapToTurnPages,
        'volumeButtonPageTurn': volumeButtonPageTurn,
        'enableAnimations': enableAnimations,
        // Goals
        'dailyGoalMinutes': dailyGoalMinutes,
        'yearlyBookGoal': yearlyBookGoal,
        // Notifications & Reminders
        'pushNotifications': pushNotifications,
        'readingReminders': readingReminders,
        'dailyReminderEnabled': dailyReminderEnabled,
        'streakReminder': streakReminder,
        'reminderHour': reminderTime.hour,
        'reminderMinute': reminderTime.minute,
        // Appearance
        'themeMode': themeMode.index,
        'appTheme': appTheme,
        'accentColor': accentColor.value,
        // Storage & Data
        'downloadOnWifiOnly': downloadOnWifiOnly,
        'wifiOnlyDownload': wifiOnlyDownload,
        'lastSyncTime': lastSyncTime?.toIso8601String(),
      };

  // ─────────────────────────────────────────
  // DESERIALIZATION
  // ─────────────────────────────────────────

  factory AppSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final reminderHour = json['reminderHour'] ?? 20;
    final reminderMinute = json['reminderMinute'] ?? 0;

    return AppSettings(
      // Reading
      fontSize: (json['fontSize'] ?? 16.0).toDouble(),
      lineSpacing:
          (json['lineSpacing'] ?? 1.5).toDouble(),
      readingTheme: json['readingTheme'] ?? 'light',
      keepScreenOn: json['keepScreenOn'] ?? true,
      autoRotate: json['autoRotate'] ?? false,
      tapToTurnPages: json['tapToTurnPages'] ?? false,
      volumeButtonPageTurn:
          json['volumeButtonPageTurn'] ?? false,
      enableAnimations:
          json['enableAnimations'] ?? true,
      // Goals
      dailyGoalMinutes: json['dailyGoalMinutes'] ?? 30,
      yearlyBookGoal: json['yearlyBookGoal'] ?? 12,
      // Notifications & Reminders
      pushNotifications:
          json['pushNotifications'] ?? true,
      readingReminders:
          json['readingReminders'] ?? false,
      dailyReminderEnabled:
          json['dailyReminderEnabled'] ?? false,
      streakReminder: json['streakReminder'] ?? true,
      reminderTime: TimeOfDay(
        hour: reminderHour,
        minute: reminderMinute,
      ),
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      // Appearance
      themeMode:
          ThemeMode.values[json['themeMode'] ?? 0],
      appTheme: json['appTheme'] ?? 'system',
      accentColor: Color(
        json['accentColor'] ?? Colors.blue.value,
      ),
      // Storage & Data
      downloadOnWifiOnly:
          json['downloadOnWifiOnly'] ?? true,
      wifiOnlyDownload:
          json['wifiOnlyDownload'] ?? false,
      lastSyncTime: json['lastSyncTime'] != null
          ? DateTime.parse(json['lastSyncTime'])
          : null,
    );
  }

  // ─────────────────────────────────────────
  // PROPS
  // ─────────────────────────────────────────

  @override
  List<Object?> get props => [
        // Reading
        fontSize,
        lineSpacing,
        readingTheme,
        keepScreenOn,
        autoRotate,
        tapToTurnPages,
        volumeButtonPageTurn,
        enableAnimations,
        // Goals
        dailyGoalMinutes,
        yearlyBookGoal,
        // Notifications & Reminders
        pushNotifications,
        readingReminders,
        dailyReminderEnabled,
        streakReminder,
        reminderTime,
        reminderHour,
        reminderMinute,
        // Appearance
        themeMode,
        appTheme,
        accentColor,
        // Storage & Data
        downloadOnWifiOnly,
        wifiOnlyDownload,
        lastSyncTime,
      ];
}