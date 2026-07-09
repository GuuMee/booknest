// lib/services/notification_service.dart

import 'dart:convert';                              // jsonDecode, jsonEncode
import 'dart:io';                                   // File

import 'package:dio/dio.dart';                      // Dio, Options, ResponseType
import 'package:firebase_messaging/firebase_messaging.dart'; // FirebaseMessaging,
                                                    // RemoteMessage
import 'package:flutter/foundation.dart';           // debugPrint
import 'package:flutter/material.dart';             // Color
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
                                                    // FlutterLocalNotificationsPlugin
                                                    // AndroidInitializationSettings
                                                    // DarwinInitializationSettings
                                                    // InitializationSettings
                                                    // NotificationResponse
                                                    // AndroidNotificationDetails
                                                    // DarwinNotificationDetails
                                                    // NotificationDetails
                                                    // Importance, Priority
                                                    // BigPictureStyleInformation
                                                    // BigTextStyleInformation
                                                    // FilePathAndroidBitmap
                                                    // AndroidScheduleMode
                                                    // UILocalNotificationDateInterpretation
                                                    // DateTimeComponents
import 'package:path_provider/path_provider.dart';  // getTemporaryDirectory
import 'package:timezone/timezone.dart' as tz;      // tz.TZDateTime, tz.local

// Core - Navigation
import '../core/navigation/navigator_key.dart';     // navigatorKey

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // ─────────────────────────────────────────
  // INIT
  // ─────────────────────────────────────────

  Future<void> initialize() async {
    // Local Notifications setup
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse:
          _onNotificationTap,
    );

    // FCM Setup
    await _requestPermission();
    await _setupFCM();
  }

  // ─────────────────────────────────────────
  // PERMISSIONS
  // ─────────────────────────────────────────

  Future<void> _requestPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint(
      'Notification permission: '
      '${settings.authorizationStatus}',
    );
  }

  // ─────────────────────────────────────────
  // FCM SETUP
  // ─────────────────────────────────────────

  Future<void> _setupFCM() async {
    final token = await _fcm.getToken();
    debugPrint('FCM Token: $token');

    // Save token to server
    if (token != null) {
      // await _apiService.registerFCMToken(token);
    }

    // Token refresh listener
    _fcm.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
      // await _apiService.registerFCMToken(newToken);
    });

    // Foreground messages
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        _showNotification(
          title:
              message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: message.data.toString(),
        );
      },
    );

    // Background message tap
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        _handleMessageNavigation(message.data);
      },
    );

    // App opened from terminated state
    final initialMessage =
        await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(
        initialMessage.data,
      );
    }

    // Subscribe to topics
    await _fcm.subscribeToTopic('all_users');
    await _fcm.subscribeToTopic('new_books');
  }

  // ─────────────────────────────────────────
  // NAVIGATION
  // ─────────────────────────────────────────

  void _handleMessageNavigation(
    Map<String, dynamic> data,
  ) {
    final type = data['type'] as String?;
    final id = data['id'] as String?;

    switch (type) {
      case 'book':
        if (id != null) {
          navigatorKey.currentState
              ?.pushNamed('/book/$id');
        }
        break;
      case 'category':
        if (id != null) {
          navigatorKey.currentState
              ?.pushNamed('/category/$id');
        }
        break;
      case 'promo':
        navigatorKey.currentState
            ?.pushNamed('/subscription');
        break;
      default:
        navigatorKey.currentState?.pushNamed('/');
    }
  }

  // ─────────────────────────────────────────
  // SHOW NOTIFICATION
  // ─────────────────────────────────────────

  Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
    String? imageUrl,
  }) async {
    AndroidNotificationDetails androidDetails;

    if (imageUrl != null) {
      final bigPicture =
          await _downloadImage(imageUrl);
      androidDetails = AndroidNotificationDetails(
        'booknest_main',
        'BookNest Notifications',
        channelDescription:
            'Main notification channel',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: bigPicture != null
            ? BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicture),
                contentTitle: title,
                summaryText: body,
              )
            : BigTextStyleInformation(body),
        icon: '@mipmap/ic_launcher',
        color: const Color(0xFF6366F1),
      );
    } else {
      androidDetails =
          const AndroidNotificationDetails(
        'booknest_main',
        'BookNest Notifications',
        channelDescription:
            'Main notification channel',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation:
            BigTextStyleInformation(''),
        icon: '@mipmap/ic_launcher',
        color: Color(0xFF6366F1),
      );
    }

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now()
          .millisecondsSinceEpoch
          .remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }

  // ─────────────────────────────────────────
  // IMAGE DOWNLOAD
  // ─────────────────────────────────────────

  Future<String?> _downloadImage(
    String url,
  ) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/notification_image.jpg',
      );
      await file.writeAsBytes(response.data);
      return file.path;
    } catch (_) {
      return null;
    }
  }

  // ─────────────────────────────────────────
  // NOTIFICATION TAP
  // ─────────────────────────────────────────

  void _onNotificationTap(
    NotificationResponse response,
  ) {
    if (response.payload != null) {
      try {
        final data = jsonDecode(
          response.payload!,
        ) as Map<String, dynamic>;
        _handleMessageNavigation(data);
      } catch (_) {
        debugPrint(
          'Invalid notification payload',
        );
      }
    }
  }

  // ─────────────────────────────────────────
  // SCHEDULED — Daily Reminder
  // ─────────────────────────────────────────

  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    await _notifications.zonedSchedule(
      0, // Fixed ID for daily reminder
      '📚 Time to Read!',
      'Your daily reading goal awaits.'
          ' Just 15 minutes can make a difference!',
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'booknest_reminders',
          'Reading Reminders',
          channelDescription:
              'Daily reading reminder notifications',
          importance: Importance.high,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
          color: Color(0xFF6366F1),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode:
          AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation
              .absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(
    int hour,
    int minute,
  ) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(
        const Duration(days: 1),
      );
    }
    return scheduledDate;
  }

  Future<void> cancelDailyReminder() async {
    await _notifications.cancel(0);
  }

  // ─────────────────────────────────────────
  // SCHEDULED — Streak Reminder
  // ─────────────────────────────────────────

  Future<void> scheduleStreakReminder() async {
    await _notifications.zonedSchedule(
      1,
      '🔥 Keep your streak alive!',
      'You haven\'t read today yet.'
          ' Open a book to maintain your reading streak!',
      _nextInstanceOfTime(21, 0), // 9 PM
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'booknest_streak',
          'Streak Reminders',
          channelDescription:
              'Reading streak notifications',
          importance: Importance.high,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode:
          AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation
              .absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time,
    );
  }

  // ─────────────────────────────────────────
  // ONE-TIME — Download Complete
  // ─────────────────────────────────────────

  Future<void> showDownloadComplete(
    String bookTitle,
  ) async {
    await _showNotification(
      title: '✅ Download Complete',
      body:
          '"$bookTitle" is ready to read offline!',
      payload: jsonEncode(
        {'type': 'download_complete'},
      ),
    );
  }

  // ─────────────────────────────────────────
  // ONE-TIME — Achievement Unlocked
  // ─────────────────────────────────────────

  Future<void> showAchievementUnlocked(
    String achievementName,
  ) async {
    await _showNotification(
      title: '🏆 Achievement Unlocked!',
      body: 'You earned: $achievementName',
      payload: jsonEncode(
        {'type': 'achievement'},
      ),
    );
  }

  // ─────────────────────────────────────────
  // CANCEL ALL
  // ─────────────────────────────────────────

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}