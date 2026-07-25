// lib/presentation/screens/settings/settings_screen.dart

import 'package:flutter/material.dart';                           // StatelessWidget
                                                                  // StatefulWidget
                                                                  // Widget, BuildContext
                                                                  // Scaffold, AppBar
                                                                  // ListView, Column, Row
                                                                  // Container, Padding
                                                                  // SizedBox, Divider
                                                                  // Text, TextStyle
                                                                  // TextField, InputDecoration
                                                                  // ElevatedButton, TextButton
                                                                  // IconButton, Switch
                                                                  // ListTile, AlertDialog
                                                                  // Slider, GestureDetector
                                                                  // Icon, Icons, Colors
                                                                  // CircularProgressIndicator
                                                                  // ScaffoldMessenger
                                                                  // SnackBar, Navigator
                                                                  // showModalBottomSheet
                                                                  // showDialog, showTimePicker
                                                                  // StatefulBuilder
                                                                  // TimeOfDay, DayPeriod
                                                                  // Theme, ColorScheme
                                                                  // VoidCallback
                                                                  // BoxDecoration, BoxShadow
                                                                  // BorderRadius, Border
                                                                  // BoxShape, Offset
import 'package:flutter_bloc/flutter_bloc.dart';                  // BlocBuilder
                                                                  // context.read
import 'package:go_router/go_router.dart';                        // context.push
import 'package:url_launcher/url_launcher.dart';                  // canLaunchUrl
                                                                  // launchUrl
                                                                  // LaunchMode

// Presentation - BLoC - Auth
import '../../blocs/auth/auth_bloc.dart';                         // AuthBloc
                                                                  // SignOutRequested
                                                                  // DeleteAccountRequested
                                                                  // ChangePasswordRequested

// Presentation - BLoC - Settings
import '../../blocs/settings/settings_bloc.dart';                 // SettingsBloc
                                                                  // SettingsState
                                                                  // SettingsLoaded
                                                                  // UpdateSettings
                                                                  // SyncData
                                                                  // ClearCache

// Data - Models
import '../../../data/models/app_settings.dart';                  // AppSettings

// Core - Theme
import '../../../core/theme/app_colors.dart';                     // AppColors

// Core - Extensions
import '../../../core/extensions/string_extensions.dart';         // capitalize()

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN — SettingsScreen
// ─────────────────────────────────────────────────────────────────────────────

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;

          return ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              // ===== READING PREFERENCES =====
              _SettingsSection(
                title: 'Reading Preferences',
                children: [
                  _SettingsTile(
                    icon: Icons.text_fields_rounded,
                    iconColor: Colors.blue,
                    title: 'Font Size',
                    subtitle: '${settings.fontSize.toInt()} pt',
                    onTap: () =>
                        _showFontSizePicker(context, settings),
                  ),
                  _SettingsTile(
                    icon: Icons.format_line_spacing_rounded,
                    iconColor: Colors.green,
                    title: 'Line Spacing',
                    subtitle: '${settings.lineSpacing}x',
                    onTap: () =>
                        _showLineSpacingPicker(context, settings),
                  ),
                  _SettingsTile(
                    icon: Icons.brightness_6_rounded,
                    iconColor: Colors.orange,
                    title: 'Reading Theme',
                    subtitle: settings.readingTheme.capitalize(),
                    onTap: () =>
                        _showThemePicker(context, settings),
                  ),
                  _SwitchTile(
                    icon: Icons.screen_lock_portrait_rounded,
                    iconColor: Colors.purple,
                    title: 'Keep Screen On',
                    subtitle:
                        'Prevent screen from turning off while reading',
                    value: settings.keepScreenOn,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                  keepScreenOn: value),
                            ),
                          );
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.swipe_rounded,
                    iconColor: Colors.teal,
                    title: 'Tap to Turn Pages',
                    subtitle: 'Tap edges instead of swiping',
                    value: settings.tapToTurnPages,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                  tapToTurnPages: value),
                            ),
                          );
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.volume_up_rounded,
                    iconColor: Colors.indigo,
                    title: 'Volume Button Page Turn',
                    subtitle: 'Use volume buttons to turn pages',
                    value: settings.volumeButtonPageTurn,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                volumeButtonPageTurn: value,
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== GOALS & TRACKING =====
              _SettingsSection(
                title: 'Goals & Tracking',
                children: [
                  _SettingsTile(
                    icon: Icons.flag_rounded,
                    iconColor: Colors.red,
                    title: 'Daily Reading Goal',
                    subtitle:
                        '${settings.dailyGoalMinutes} minutes per day',
                    onTap: () =>
                        _showDailyGoalPicker(context, settings),
                  ),
                  _SettingsTile(
                    icon: Icons.auto_stories_rounded,
                    iconColor: Colors.amber.shade700,
                    title: 'Yearly Reading Goal',
                    subtitle:
                        '${settings.yearlyBookGoal} books per year',
                    onTap: () =>
                        _showYearlyGoalPicker(context, settings),
                  ),
                  _SwitchTile(
                    icon: Icons.notifications_rounded,
                    iconColor: Colors.pink,
                    title: 'Reading Reminders',
                    subtitle: 'Get reminded to read daily',
                    value: settings.readingReminders,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                readingReminders: value,
                              ),
                            ),
                          );
                    },
                  ),
                  if (settings.readingReminders)
                    _SettingsTile(
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.cyan,
                      title: 'Reminder Time',
                      subtitle:
                          _formatTimeOfDay(settings.reminderTime),
                      onTap: () =>
                          _showTimePicker(context, settings),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== APPEARANCE =====
              _SettingsSection(
                title: 'Appearance',
                children: [
                  _SettingsTile(
                    icon: Icons.dark_mode_rounded,
                    iconColor: Colors.deepPurple,
                    title: 'App Theme',
                    subtitle: settings.appTheme.capitalize(),
                    onTap: () =>
                        _showAppThemePicker(context, settings),
                  ),
                  _SwitchTile(
                    icon: Icons.animation_rounded,
                    iconColor: Colors.lightBlue,
                    title: 'Animations',
                    subtitle: 'Enable page turn animations',
                    value: settings.enableAnimations,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                enableAnimations: value,
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== STORAGE & DATA =====
              _SettingsSection(
                title: 'Storage & Data',
                children: [
                  _SwitchTile(
                    icon: Icons.wifi_off_rounded,
                    iconColor: Colors.grey.shade700,
                    title: 'Download on Wi-Fi Only',
                    subtitle:
                        'Save mobile data when downloading books',
                    value: settings.downloadOnWifiOnly,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(
                              settings: settings.copyWith(
                                downloadOnWifiOnly: value,
                              ),
                            ),
                          );
                    },
                  ),
                  _SettingsTile(
                    icon: Icons.storage_rounded,
                    iconColor: Colors.brown,
                    title: 'Storage Usage',
                    subtitle: 'Manage downloaded books',
                    onTap: () => context.push('/storage'),
                  ),
                  _SettingsTile(
                    icon: Icons.delete_sweep_rounded,
                    iconColor: Colors.red.shade400,
                    title: 'Clear Cache',
                    subtitle:
                        'Free up space by clearing cached data',
                    onTap: () => _showClearCacheDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== ACCOUNT =====
              _SettingsSection(
                title: 'Account',
                children: [
                  _SettingsTile(
                    icon: Icons.person_rounded,
                    iconColor: Colors.blue,
                    title: 'Edit Profile',
                    subtitle: 'Name, photo, bio',
                    onTap: () => context.push('/edit-profile'),
                  ),
                  _SettingsTile(
                    icon: Icons.lock_rounded,
                    iconColor: Colors.green,
                    title: 'Change Password',
                    onTap: () =>
                        _showChangePasswordSheet(context),
                  ),
                  _SettingsTile(
                    icon: Icons.cloud_sync_rounded,
                    iconColor: Colors.indigo,
                    title: 'Sync Data',
                    subtitle:
                        'Last synced: ${_formatLastSync(settings.lastSyncTime)}',
                    onTap: () {
                      context
                          .read<SettingsBloc>()
                          .add(SyncData());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== ABOUT =====
              _SettingsSection(
                title: 'About',
                children: [
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    iconColor: Colors.blue,
                    title: 'About',
                    subtitle: 'Version 1.0.0',
                    onTap: () => _showAboutDialog(context),
                  ),
                  _SettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    iconColor: Colors.teal,
                    title: 'Privacy Policy',
                    onTap: () => _launchUrl(
                        'https://example.com/privacy'),
                  ),
                  _SettingsTile(
                    icon: Icons.description_outlined,
                    iconColor: Colors.orange,
                    title: 'Terms of Service',
                    onTap: () =>
                        _launchUrl('https://example.com/terms'),
                  ),
                  _SettingsTile(
                    icon: Icons.mail_outline_rounded,
                    iconColor: Colors.purple,
                    title: 'Contact Support',
                    onTap: () => _launchUrl(
                        'mailto:support@example.com'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== DANGER ZONE =====
              _SettingsSection(
                title: 'Danger Zone',
                titleColor: Colors.red,
                children: [
                  _SettingsTile(
                    icon: Icons.logout_rounded,
                    iconColor: Colors.orange,
                    title: 'Sign Out',
                    onTap: () => _showSignOutDialog(context),
                  ),
                  _SettingsTile(
                    icon: Icons.delete_forever_rounded,
                    iconColor: Colors.red,
                    title: 'Delete Account',
                    subtitle: 'This action cannot be undone',
                    titleColor: Colors.red,
                    onTap: () =>
                        _showDeleteAccountDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // HELPER METHODS
  // ─────────────────────────────────────────

  String _formatTimeOfDay(TimeOfDay time) {
    final hour =
        time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute =
        time.minute.toString().padLeft(2, '0');
    final period =
        time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _formatLastSync(DateTime? lastSync) {
    if (lastSync == null) return 'Never';
    final diff = DateTime.now().difference(lastSync);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // ─────────────────────────────────────────
  // FONT SIZE PICKER
  // ─────────────────────────────────────────

  void _showFontSizePicker(
      BuildContext context, AppSettings settings) {
    double fontSize = settings.fontSize;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Font Size',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preview
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      'The quick brown fox jumps over the lazy dog. '
                      'This is how your reading text will appear.',
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Slider
                  Row(
                    children: [
                      const Text(
                        'A',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: fontSize,
                          min: 12,
                          max: 32,
                          divisions: 20,
                          activeColor: AppColors.primary,
                          label: '${fontSize.round()} pt',
                          onChanged: (value) {
                            setSheetState(
                                () => fontSize = value);
                          },
                        ),
                      ),
                      const Text(
                        'A',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Apply button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings: settings.copyWith(
                                    fontSize: fontSize),
                              ),
                            );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // LINE SPACING PICKER
  // ─────────────────────────────────────────

  void _showLineSpacingPicker(
      BuildContext context, AppSettings settings) {
    final options = [1.0, 1.2, 1.4, 1.6, 1.8, 2.0];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Line Spacing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              ...options.map((option) {
                final isSelected =
                    settings.lineSpacing == option;
                return ListTile(
                  onTap: () {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            settings: settings.copyWith(
                                lineSpacing: option),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : null,
                  leading: Icon(
                    Icons.format_line_spacing_rounded,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade400,
                  ),
                  title: Text(
                    '${option}x',
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.primary
                          : Colors.black87,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                        )
                      : null,
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // READING THEME PICKER
  // ─────────────────────────────────────────

  void _showThemePicker(
      BuildContext context, AppSettings settings) {
    final themes = [
      {
        'id': 'light',
        'name': 'Light',
        'bg': Colors.white,
        'text': Colors.black87,
        'icon': Icons.wb_sunny_rounded,
      },
      {
        'id': 'sepia',
        'name': 'Sepia',
        'bg': const Color(0xFFF5E6C8),
        'text': const Color(0xFF5B4636),
        'icon': Icons.auto_awesome_rounded,
      },
      {
        'id': 'dark',
        'name': 'Dark',
        'bg': const Color(0xFF1E1E1E),
        'text': const Color(0xFFE0E0E0),
        'icon': Icons.dark_mode_rounded,
      },
      {
        'id': 'amoled',
        'name': 'AMOLED',
        'bg': Colors.black,
        'text': Colors.white,
        'icon': Icons.brightness_1_rounded,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Reading Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: themes.map((theme) {
                  final isSelected =
                      settings.readingTheme == theme['id'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings: settings.copyWith(
                                  readingTheme:
                                      theme['id'] as String,
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme['bg'] as Color,
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade200,
                            width: isSelected ? 2.5 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              theme['icon'] as IconData,
                              color: theme['text'] as Color,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Abc',
                              style: TextStyle(
                                color: theme['text'] as Color,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              theme['name'] as String,
                              style: TextStyle(
                                color: theme['text'] as Color,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // DAILY GOAL PICKER
  // ─────────────────────────────────────────

  void _showDailyGoalPicker(
      BuildContext context, AppSettings settings) {
    int goal = settings.dailyGoalMinutes;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Daily Reading Goal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How many minutes do you want to read each day?',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '$goal',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'minutes per day',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Slider(
                    value: goal.toDouble(),
                    min: 5,
                    max: 120,
                    divisions: 23,
                    activeColor: AppColors.primary,
                    label: '$goal min',
                    onChanged: (value) {
                      setSheetState(
                          () => goal = value.round());
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children:
                        [15, 30, 45, 60, 90].map((minutes) {
                      final isSelected = goal == minutes;
                      return GestureDetector(
                        onTap: () {
                          setSheetState(() => goal = minutes);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade100,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${minutes}m',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings: settings.copyWith(
                                  dailyGoalMinutes: goal,
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save Goal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // YEARLY GOAL PICKER
  // ─────────────────────────────────────────

    void _showYearlyGoalPicker(
      BuildContext context, AppSettings settings) {
    int goal = settings.yearlyBookGoal;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Yearly Reading Goal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Minus button
                      _CircleButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (goal > 1) {
                            setSheetState(() => goal--);
                          }
                        },
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            '$goal',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'books this year',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      // Plus button
                      _CircleButton(
                        icon: Icons.add,
                        onTap: () {
                          setSheetState(() => goal++);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Quick picks
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children:
                        [6, 12, 24, 52, 100].map((count) {
                      final isSelected = goal == count;
                      return GestureDetector(
                        onTap: () {
                          setSheetState(() => goal = count);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade100,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$count',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings: settings.copyWith(
                                  yearlyBookGoal: goal,
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save Goal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // APP THEME PICKER
  // ─────────────────────────────────────────

  void _showAppThemePicker(
      BuildContext context, AppSettings settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'App Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              ...['system', 'light', 'dark'].map((theme) {
                final isSelected = settings.appTheme == theme;
                final icons = {
                  'system':
                      Icons.settings_brightness_rounded,
                  'light': Icons.wb_sunny_rounded,
                  'dark': Icons.dark_mode_rounded,
                };
                final labels = {
                  'system': 'System Default',
                  'light': 'Light Mode',
                  'dark': 'Dark Mode',
                };
                final subtitles = {
                  'system': 'Follow your device settings',
                  'light': 'Always use light theme',
                  'dark': 'Always use dark theme',
                };

                return ListTile(
                  onTap: () {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            settings: settings.copyWith(
                                appTheme: theme),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: isSelected
                      ? AppColors.primary.withOpacity(0.08)
                      : null,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icons[theme],
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade600,
                    ),
                  ),
                  title: Text(
                    labels[theme]!,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.primary
                          : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    subtitles[theme]!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                        )
                      : null,
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // TIME PICKER
  // ─────────────────────────────────────────

  Future<void> _showTimePicker(
    BuildContext context,
    AppSettings settings,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: settings.reminderTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      context.read<SettingsBloc>().add(
            UpdateSettings(
              settings:
                  settings.copyWith(reminderTime: picked),
            ),
          );
    }
  }

  // ─────────────────────────────────────────
  // CLEAR CACHE DIALOG
  // ─────────────────────────────────────────

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.delete_sweep_rounded,
                  color: Colors.orange),
              SizedBox(width: 10),
              Text(
                'Clear Cache',
                style:
                    TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: const Text(
            'This will clear cached images and temporary files. '
            'Your books and reading progress won\'t be affected.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<SettingsBloc>()
                    .add(ClearCache());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                        'Cache cleared successfully ✅'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // SIGN OUT DIALOG
  // ─────────────────────────────────────────

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Sign Out',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Are you sure you want to sign out? '
            'Your data will be synced when you sign back in.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<AuthBloc>()
                    .add(SignOutRequested());
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // DELETE ACCOUNT DIALOG
  // ─────────────────────────────────────────

  void _showDeleteAccountDialog(BuildContext context) {
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded,
                  color: Colors.red.shade600),
              const SizedBox(width: 10),
              const Text(
                'Delete Account',
                style:
                    TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This will permanently delete your account '
                'and all associated data including:',
              ),
              const SizedBox(height: 12),
              _DeleteItem('Your reading history'),
              _DeleteItem('All bookmarks and highlights'),
              _DeleteItem('Your reviews and ratings'),
              _DeleteItem('Reading statistics'),
              const SizedBox(height: 16),
              Text(
                'Type "DELETE" to confirm',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmController,
                decoration: InputDecoration(
                  hintText: 'DELETE',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              onPressed: () {
                if (confirmController.text == 'DELETE') {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(
                      DeleteAccountRequested());
                }
              },
              child: Text(
                'Delete Forever',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // CHANGE PASSWORD SHEET
  // ─────────────────────────────────────────

  void _showChangePasswordSheet(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              _PasswordField(
                controller: currentPasswordController,
                label: 'Current Password',
              ),
              const SizedBox(height: 14),
              _PasswordField(
                controller: newPasswordController,
                label: 'New Password',
              ),
              const SizedBox(height: 14),
              _PasswordField(
                controller: confirmPasswordController,
                label: 'Confirm New Password',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final newPass =
                        newPasswordController.text;
                    final confirmPass =
                        confirmPasswordController.text;

                    if (newPass != confirmPass) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                              Text('Passwords don\'t match'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (newPass.length < 6) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password must be at least 6 characters',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    context.read<AuthBloc>().add(
                          ChangePasswordRequested(
                            currentPassword:
                                currentPasswordController
                                    .text,
                            newPassword: newPass,
                          ),
                        );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Update Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // ABOUT DIALOG
  // ─────────────────────────────────────────

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color:
                      AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'BookNest',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your personal reading companion. '
                'Track your reading, discover new books, '
                'and build a lifelong reading habit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Made with ❤️ for book lovers',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // LAUNCH URL
  // ─────────────────────────────────────────

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _DeleteItem
// ─────────────────────────────────────────────────────────────────────────────

class _DeleteItem extends StatelessWidget {
  final String text;
  const _DeleteItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.remove_circle,
              color: Colors.red.shade300, size: 16),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _CircleButton
// ─────────────────────────────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.grey.shade700),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _PasswordField
// ─────────────────────────────────────────────────────────────────────────────

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const _PasswordField({
    required this.controller,
    required this.label,
  });

  @override
  State<_PasswordField> createState() =>
      _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            TextStyle(color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: Colors.grey.shade500,
          ),
          onPressed: () {
            setState(() => _obscure = !_obscure);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _SettingsSection
// ─────────────────────────────────────────────────────────────────────────────

class _SettingsSection extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    this.titleColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: titleColor ?? Colors.black87,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children:
                List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index < children.length - 1)
                    Divider(
                      height: 1,
                      indent: 56,
                      color: Colors.grey.shade100,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _SettingsTile
// ─────────────────────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black87,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey.shade400,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _SwitchTile
// ─────────────────────────────────────────────────────────────────────────────

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}