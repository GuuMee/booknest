// lib/presentation/blocs/settings/settings_bloc.dart

import 'dart:convert';                                            // json.decode
                                                                  // json.encode
import 'dart:io';                                                 // Directory
                                                                  // FileSystemEntity

import 'package:equatable/equatable.dart';                        // Equatable
                                                                  // List<Object?>
                                                                  // get props

import 'package:flutter/foundation.dart';                         // debugPrint
import 'package:flutter/painting.dart';                           // PaintingBinding
                                                                  // .imageCache
                                                                  // .clear()
                                                                  // .clearLiveImages()

import 'package:flutter_bloc/flutter_bloc.dart';                  // Bloc<Event, State>
                                                                  // Emitter<State>
                                                                  // on<Event>()

import 'package:shared_preferences/shared_preferences.dart';      // SharedPreferences
                                                                  // .getString()
                                                                  // .setString()

import 'package:cloud_firestore/cloud_firestore.dart';            // FirebaseFirestore
                                                                  // SetOptions
                                                                  // .collection()
                                                                  // .doc()
                                                                  // .get()
                                                                  // .set()

import 'package:firebase_auth/firebase_auth.dart';                // FirebaseAuth
                                                                  // .currentUser
                                                                  // .uid

import 'package:path_provider/path_provider.dart';                // getTemporaryDirectory()

// Data - Models
import '../../../data/models/app_settings.dart';                  // AppSettings
                                                                  // AppSettings()
                                                                  // .fromJson()
                                                                  // .toJson()
                                                                  // .copyWith()
                                                                  // .dailyReminderEnabled
                                                                  // .reminderHour
                                                                  // .reminderMinute

// Services
import '../../../services/notification_service.dart';             // NotificationService
                                                                  // .scheduleDailyReminder()
                                                                  // .cancelDailyReminder()

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final AppSettings settings;

  const UpdateSettings({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class SyncData extends SettingsEvent {}

class ClearCache extends SettingsEvent {}

class ResetSettings extends SettingsEvent {}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final AppSettings settings;

  const SettingsLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class SettingsBloc
    extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final NotificationService _notificationService;

  SettingsBloc({
    required SharedPreferences prefs,
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required NotificationService notificationService,
  })  : _prefs = prefs,
        _firestore = firestore,
        _auth = auth,
        _notificationService = notificationService,
        super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<SyncData>(_onSyncData);
    on<ClearCache>(_onClearCache);
    on<ResetSettings>(_onResetSettings);
  }

  // ─────────────────────────────────────────
  // LOAD SETTINGS
  // ─────────────────────────────────────────

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    try {
      final settingsJson =
          _prefs.getString('app_settings');

      if (settingsJson != null) {
        final settings = AppSettings.fromJson(
          json.decode(settingsJson)
              as Map<String, dynamic>,
        );
        emit(SettingsLoaded(settings: settings));
      } else {
        // Try loading from Firestore
        final userId = _auth.currentUser?.uid;
        if (userId != null) {
          final doc = await _firestore
              .collection('users')
              .doc(userId)
              .collection('settings')
              .doc('preferences')
              .get();

          if (doc.exists) {
            final settings = AppSettings.fromJson(
              doc.data() as Map<String, dynamic>,
            );
            await _saveLocal(settings);
            emit(SettingsLoaded(settings: settings));
            return;
          }
        }

        // Default settings
        emit(const SettingsLoaded(
            settings: AppSettings()));
      }
    } catch (e) {
      emit(const SettingsLoaded(
          settings: AppSettings()));
    }
  }

  // ─────────────────────────────────────────
  // UPDATE SETTINGS
  // ─────────────────────────────────────────

  Future<void> _onUpdateSettings(
    UpdateSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      // Save locally
      await _saveLocal(event.settings);

      // Handle notifications
      if (event.settings.dailyReminderEnabled) {
        await _notificationService
            .scheduleDailyReminder(
          hour: event.settings.reminderHour,
          minute: event.settings.reminderMinute,
        );
      } else {
        await _notificationService
            .cancelDailyReminder();
      }

      emit(SettingsLoaded(settings: event.settings));

      // Save to Firestore in background
      _saveRemote(event.settings);
    } catch (e) {
      emit(SettingsError(
          message: 'Failed to save settings: $e'));
    }
  }

  // ─────────────────────────────────────────
  // SYNC DATA
  // ─────────────────────────────────────────

  Future<void> _onSyncData(
    SyncData event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      // Push local settings to Firestore
      await _saveRemote(currentState.settings);

      // Update last sync time
      final updatedSettings =
          currentState.settings.copyWith(
        lastSyncTime: DateTime.now(),
      );
      await _saveLocal(updatedSettings);

      emit(SettingsLoaded(settings: updatedSettings));
    } catch (e) {
      emit(SettingsError(
          message: 'Sync failed: $e'));
      // Re-emit the loaded state so UI doesn't break
      emit(currentState);
    }
  }

  // ─────────────────────────────────────────
  // CLEAR CACHE
  // ─────────────────────────────────────────

  Future<void> _onClearCache(
    ClearCache event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      // Clear image cache
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache
          .clearLiveImages();

      // Clear temporary files
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        tempDir.listSync().forEach((file) {
          try {
            file.deleteSync(recursive: true);
          } catch (_) {}
        });
      }

      debugPrint('Cache cleared successfully');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  // ─────────────────────────────────────────
  // RESET SETTINGS
  // ─────────────────────────────────────────

  Future<void> _onResetSettings(
    ResetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      const defaultSettings = AppSettings();

      await _saveLocal(defaultSettings);

      await _notificationService
          .cancelDailyReminder();

      // Sync reset to Firestore in background
      _saveRemote(defaultSettings);

      emit(const SettingsLoaded(
          settings: defaultSettings));
    } catch (e) {
      emit(SettingsError(
          message: 'Failed to reset settings: $e'));
    }
  }

  // ─────────────────────────────────────────
  // PRIVATE HELPERS
  // ─────────────────────────────────────────

  Future<void> _saveLocal(
      AppSettings settings) async {
    await _prefs.setString(
      'app_settings',
      json.encode(settings.toJson()),
    );
  }

  Future<void> _saveRemote(
      AppSettings settings) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('settings')
          .doc('preferences')
          .set(
            settings.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      debugPrint(
          'Failed to save settings to Firestore: $e');
    }
  }
}