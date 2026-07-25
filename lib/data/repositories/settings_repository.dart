// lib/data/repositories/settings_repository.dart

import 'dart:convert';                              // jsonDecode()
                                                    // jsonEncode()

import 'dart:io';                                   // Directory
                                                    // .existsSync()
                                                    // .delete()
                                                    // .create()

import 'package:flutter/painting.dart';             // PaintingBinding
                                                    // .instance
                                                    // .imageCache
                                                    // .clear()
                                                    // .clearLiveImages()

import 'package:path_provider/path_provider.dart';  // getTemporaryDirectory()

import 'package:shared_preferences/shared_preferences.dart';
                                                    // SharedPreferences
                                                    // .getString()
                                                    // .setString()

// Data - Models
import '../models/app_settings.dart';               // AppSettings
                                                    // AppSettings()
                                                    // .fromJson()
                                                    // .toJson()

// ─────────────────────────────────────────────────────────────────────────────
// REPOSITORY
// ─────────────────────────────────────────────────────────────────────────────

class SettingsRepository {
  // ─────────────────────────────────────────
  // CONSTANTS
  // ─────────────────────────────────────────

  static const _settingsKey = 'app_settings';

  // ─────────────────────────────────────────
  // DEPENDENCIES
  // ─────────────────────────────────────────

  final SharedPreferences _prefs;

  // ─────────────────────────────────────────
  // CONSTRUCTOR
  // ─────────────────────────────────────────

  SettingsRepository({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  // ─────────────────────────────────────────
  // READ
  // ─────────────────────────────────────────

  Future<AppSettings> getSettings() async {
    final jsonString =
        _prefs.getString(_settingsKey);

    if (jsonString != null) {
      try {
        final json = jsonDecode(jsonString);
        return AppSettings.fromJson(json);
      } catch (_) {
        return const AppSettings();
      }
    }

    return const AppSettings();
  }

  // ─────────────────────────────────────────
  // WRITE
  // ─────────────────────────────────────────

  Future<void> saveSettings(
    AppSettings settings,
  ) async {
    final jsonString =
        jsonEncode(settings.toJson());
    await _prefs.setString(
      _settingsKey,
      jsonString,
    );
  }

  // ─────────────────────────────────────────
  // CACHE
  // ─────────────────────────────────────────

  Future<void> clearCache() async {
    final cacheDir =
        await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      await cacheDir.delete(recursive: true);
      await cacheDir.create();
    }

    // Clear image cache
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding
        .instance
        .imageCache
        .clearLiveImages();
  }
}