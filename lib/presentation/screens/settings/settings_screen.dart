// lib/presentation/screens/settings/settings_screen.dart

import 'dart:io';                                    // Directory, File

import 'package:flutter/foundation.dart';            // kDebugMode
import 'package:flutter/material.dart';              // StatefulWidget, Widget, etc.
import 'package:flutter_bloc/flutter_bloc.dart';     // BlocBuilder, context.read<>()
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // DefaultCacheManager
import 'package:go_router/go_router.dart';           // context.push(), context.go()
import 'package:hive/hive.dart';                     // Hive.box()
import 'package:path_provider/path_provider.dart';   // getTemporaryDirectory, getApplicationDocumentsDirectory
import 'package:share_plus/share_plus.dart';         // Share.shareXFiles, XFile

// Presentation - BLoC - Auth
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';            // DeleteAccountRequested

// Presentation - BLoC - Profile
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';      // ProfileLoaded

// Services
import '../../../services/download_service.dart';    // DownloadService
import '../../../services/notification_service.dart'; // NotificationService

// Core - Theme
import '../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  // ─────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────

  bool _notificationsEnabled = true;
  bool _dailyReminder = true;
  bool _autoDownload = false;
  bool _wifiOnly = true;
  String _readingGoal = '30';
  String _theme = 'system';
  String _downloadQuality = 'standard';

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // ─────────────────────────────────────────
  // SETTINGS PERSISTENCE
  // ─────────────────────────────────────────

  Future<void> _loadSettings() async {
    final box = Hive.box('settings');
    setState(() {
      _notificationsEnabled = box.get(
        'notificationsEnabled',
        defaultValue: true,
      );
      _dailyReminder = box.get(
        'dailyReminder',
        defaultValue: true,
      );
      _autoDownload = box.get(
        'autoDownload',
        defaultValue: false,
      );
      _wifiOnly = box.get(
        'wifiOnly',
        defaultValue: true,
      );
      _readingGoal = box.get(
        'readingGoal',
        defaultValue: '30',
      );
      _theme = box.get(
        'theme',
        defaultValue: 'system',
      );
      _downloadQuality = box.get(
        'downloadQuality',
        defaultValue: 'standard',
      );
    });
  }

  Future<void> _saveSetting(
    String key,
    dynamic value,
  ) async {
    await Hive.box('settings').put(key, value);
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // ── Reading ──────────────────────
          _buildSectionTitle('Reading'),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSettingTile(
              icon: Icons.flag_rounded,
              iconColor: Colors.green,
              title: 'Daily Reading Goal',
              subtitle: '$_readingGoal minutes',
              onTap: _showReadingGoalPicker,
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.palette_rounded,
              iconColor: Colors.purple,
              title: 'Reader Theme',
              subtitle: _theme == 'system'
                  ? 'Follow System'
                  : _theme == 'light'
                      ? 'Light'
                      : 'Dark',
              onTap: _showThemePicker,
            ),
          ]),
          const SizedBox(height: 28),

          // ── Notifications ────────────────
          _buildSectionTitle('Notifications'),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSwitchTile(
              icon: Icons.notifications_rounded,
              iconColor: Colors.blue,
              title: 'Push Notifications',
              subtitle: 'New books, recommendations',
              value: _notificationsEnabled,
              onChanged: (val) {
                setState(
                  () => _notificationsEnabled = val,
                );
                _saveSetting(
                  'notificationsEnabled',
                  val,
                );
              },
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.schedule_rounded,
              iconColor: Colors.orange,
              title: 'Daily Reading Reminder',
              subtitle:
                  'Get reminded to read every day',
              value: _dailyReminder,
              onChanged: (val) {
                setState(() => _dailyReminder = val);
                _saveSetting('dailyReminder', val);
                if (val) _showReminderTimePicker();
              },
            ),
          ]),
          const SizedBox(height: 28),

          // ── Downloads ────────────────────
          _buildSectionTitle('Downloads'),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSwitchTile(
              icon: Icons.download_rounded,
              iconColor: Colors.teal,
              title: 'Auto-Download',
              subtitle:
                  'Download books when added to library',
              value: _autoDownload,
              onChanged: (val) {
                setState(() => _autoDownload = val);
                _saveSetting('autoDownload', val);
              },
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.wifi_rounded,
              iconColor: Colors.indigo,
              title: 'Wi-Fi Only',
              subtitle: 'Download only on Wi-Fi',
              value: _wifiOnly,
              onChanged: (val) {
                setState(() => _wifiOnly = val);
                _saveSetting('wifiOnly', val);
              },
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.high_quality_rounded,
              iconColor: Colors.deepOrange,
              title: 'Download Quality',
              subtitle: _downloadQuality == 'standard'
                  ? 'Standard (smaller files)'
                  : 'High (larger files)',
              onTap: _showQualityPicker,
            ),
            _buildDivider(),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return _buildSettingTile(
                  icon: Icons.folder_rounded,
                  iconColor: Colors.brown,
                  title: 'Storage Used',
                  subtitle: state is ProfileLoaded
                      ? state.storageUsed
                      : 'Calculating...',
                  onTap: _showStorageDialog,
                );
              },
            ),
          ]),
          const SizedBox(height: 28),

          // ── Account ──────────────────────
          _buildSectionTitle('Account'),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSettingTile(
              icon: Icons.person_rounded,
              iconColor: Colors.blue,
              title: 'Edit Profile',
              onTap: () =>
                  context.push('/edit-profile'),
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.lock_rounded,
              iconColor: Colors.grey,
              title: 'Change Password',
              onTap: () =>
                  context.push('/change-password'),
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.language_rounded,
              iconColor: Colors.cyan,
              title: 'Language',
              subtitle: 'English',
              onTap: _showLanguagePicker,
            ),
          ]),
          const SizedBox(height: 28),

          // ── Data ─────────────────────────
          _buildSectionTitle('Data'),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSettingTile(
              icon: Icons.cloud_download_rounded,
              iconColor: Colors.blue,
              title: 'Export Data',
              subtitle: 'Download your reading data',
              onTap: _exportData,
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.cached_rounded,
              iconColor: Colors.amber,
              title: 'Clear Cache',
              subtitle: 'Free up storage space',
              onTap: _showClearCacheDialog,
            ),
            _buildDivider(),
            _buildSettingTile(
              icon: Icons.delete_forever_rounded,
              iconColor: Colors.red,
              title: 'Delete Account',
              subtitle:
                  'Permanently remove your account',
              onTap: _showDeleteAccountDialog,
              titleColor: Colors.red,
            ),
          ]),
          const SizedBox(height: 28),

          // ── Developer (debug only) ───────
          if (kDebugMode) ...[
            _buildSectionTitle('Developer'),
            const SizedBox(height: 12),
            _buildSettingsCard([
              _buildSettingTile(
                icon: Icons.bug_report_rounded,
                iconColor: Colors.red,
                title: 'Debug Console',
                onTap: () =>
                    context.push('/debug'),
              ),
              _buildDivider(),
              _buildSettingTile(
                icon: Icons.refresh_rounded,
                iconColor: Colors.green,
                title: 'Reset Onboarding',
                onTap: () async {
                  final box = Hive.box('settings');
                  await box.put(
                    'hasSeenOnboarding',
                    false,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Onboarding reset',
                        ),
                      ),
                    );
                  }
                },
              ),
            ]),
            const SizedBox(height: 28),
          ],

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // REUSABLE BUILDERS
  // ─────────────────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildSettingsCard(
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            )
          : null,
      trailing: Switch.adaptive(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 76,
      endIndent: 20,
      color: Colors.grey.shade100,
    );
  }

  // ─────────────────────────────────────────
  // BOTTOM SHEETS
  // ─────────────────────────────────────────

  void _showReadingGoalPicker() {
    final goals = [
      '15',
      '20',
      '30',
      '45',
      '60',
      '90',
      '120',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(2),
                  ),
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
                'Set how many minutes you want'
                ' to read each day',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: goals.map((goal) {
                  final isSelected =
                      _readingGoal == goal;
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () => _readingGoal = goal,
                      );
                      _saveSetting(
                        'readingGoal',
                        goal,
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(16),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: Colors
                                    .grey.shade200,
                              ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            goal,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight:
                                  FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'min',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white70
                                  : Colors
                                      .grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(
                height: MediaQuery.of(context)
                        .padding
                        .bottom +
                    16,
              ),
            ],
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────

  void _showThemePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
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
                  borderRadius:
                      BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Reader Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),

              ...[
                {
                  'id': 'system',
                  'label': 'Follow System',
                  'icon': Icons.brightness_auto,
                },
                {
                  'id': 'light',
                  'label': 'Light',
                  'icon': Icons.light_mode,
                },
                {
                  'id': 'dark',
                  'label': 'Dark',
                  'icon': Icons.dark_mode,
                },
              ].map((option) {
                final isSelected =
                    _theme == option['id'];
                return ListTile(
                  onTap: () {
                    setState(
                      () => _theme =
                          option['id'] as String,
                    );
                    _saveSetting(
                      'theme',
                      option['id'],
                    );
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    option['icon'] as IconData,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey,
                  ),
                  title: Text(
                    option['label'] as String,
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
                          Icons.check_circle,
                          color: AppColors.primary,
                        )
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                );
              }),

              SizedBox(
                height: MediaQuery.of(context)
                        .padding
                        .bottom +
                    16,
              ),
            ],
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────

  void _showQualityPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
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
                  borderRadius:
                      BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Download Quality',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),

              ...[
                {
                  'id': 'standard',
                  'label': 'Standard',
                  'subtitle':
                      'Smaller file size, good quality',
                },
                {
                  'id': 'high',
                  'label': 'High',
                  'subtitle':
                      'Larger files, best quality',
                },
              ].map((option) {
                final isSelected =
                    _downloadQuality == option['id'];
                return ListTile(
                  onTap: () {
                    setState(
                      () => _downloadQuality =
                          option['id']!,
                    );
                    _saveSetting(
                      'downloadQuality',
                      option['id'],
                    );
                    Navigator.pop(context);
                  },
                  title: Text(
                    option['label']!,
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
                    option['subtitle']!,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                        )
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                );
              }),

              SizedBox(
                height: MediaQuery.of(context)
                        .padding
                        .bottom +
                    16,
              ),
            ],
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────

  Future<void> _showReminderTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime:
          const TimeOfDay(hour: 20, minute: 0),
    );

    if (time != null) {
      await _saveSetting('reminderHour', time.hour);
      await _saveSetting(
        'reminderMinute',
        time.minute,
      );

      if (mounted) {
        context
            .read<NotificationService>()
            .scheduleDailyReminder(
              hour: time.hour,
              minute: time.minute,
            );
      }
    }
  }

  // ──────────────────────────────────────────

  void _showLanguagePicker() {
    final languages = [
      {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
      {'code': 'hi', 'name': 'Hindi', 'flag': '🇮🇳'},
      {'code': 'es', 'name': 'Spanish', 'flag': '🇪🇸'},
      {'code': 'fr', 'name': 'French', 'flag': '🇫🇷'},
      {'code': 'de', 'name': 'German', 'flag': '🇩🇪'},
      {'code': 'ar', 'name': 'Arabic', 'flag': '🇸🇦'},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
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
                  borderRadius:
                      BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),

              ...languages.map(
                (lang) => ListTile(
                  leading: Text(
                    lang['flag']!,
                    style:
                        const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    lang['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: lang['code'] == 'en'
                      ? Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          '${lang['name']} coming soon!',
                        ),
                        behavior:
                            SnackBarBehavior.floating,
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context)
                        .padding
                        .bottom +
                    16,
              ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────

  void _showStorageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: _calculateStorage(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              title: const Text(
                'Storage',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (snapshot.connectionState ==
                      ConnectionState.waiting)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child:
                          CircularProgressIndicator(),
                    )
                  else ...[
                    _StorageRow(
                      label: 'Downloaded Books',
                      size: data?['booksSize'] ??
                          '0 MB',
                      color: Colors.blue,
                      percentage:
                          data?['booksPercent'] ??
                              0.0,
                    ),
                    const SizedBox(height: 16),
                    _StorageRow(
                      label: 'Image Cache',
                      size: data?['cacheSize'] ??
                          '0 MB',
                      color: Colors.orange,
                      percentage:
                          data?['cachePercent'] ??
                              0.0,
                    ),
                    const SizedBox(height: 16),
                    _StorageRow(
                      label: 'App Data',
                      size: data?['appDataSize'] ??
                          '0 MB',
                      color: Colors.green,
                      percentage:
                          data?['appDataPercent'] ??
                              0.0,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding:
                          const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          Text(
                            data?['totalSize'] ??
                                '0 MB',
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                                    onPressed: () {
                    Navigator.pop(context);
                    _showClearCacheDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Clear Cache'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ──────────────────────────────────────────

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Clear Cache'),
        content: const Text(
          'This will clear cached images and temporary'
          ' files. Your downloaded books and reading'
          ' progress will NOT be affected.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _clearCache();
              if (mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Cache cleared successfully! ✨',
                    ),
                    behavior:
                        SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final confirmController =
            TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.red.shade400,
              ),
              const SizedBox(width: 8),
              const Text('Delete Account'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'This action is permanent and cannot'
                ' be undone. All your data will be'
                ' deleted including:',
              ),
              const SizedBox(height: 12),
              const _DeleteWarningItem(
                text: 'Reading progress & history',
              ),
              const _DeleteWarningItem(
                text: 'Bookmarks & annotations',
              ),
              const _DeleteWarningItem(
                text: 'Downloaded books',
              ),
              const _DeleteWarningItem(
                text: 'Subscription & purchases',
              ),
              const SizedBox(height: 16),
              const Text(
                'Type "DELETE" to confirm:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmController,
                decoration: InputDecoration(
                  hintText: 'DELETE',
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade200,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (confirmController.text
                        .trim() ==
                    'DELETE') {
                  Navigator.pop(context);
                  context
                      .read<AuthBloc>()
                      .add(DeleteAccountRequested());
                  context.go('/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Delete Forever'),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  Future<Map<String, dynamic>>
      _calculateStorage() async {
    final downloadService =
        context.read<DownloadService>();
    final booksBytes =
        await downloadService.getTotalDownloadSize();

    final cacheDir = await getTemporaryDirectory();
    final cacheBytes =
        await _getDirectorySize(cacheDir);

    final appDir =
        await getApplicationDocumentsDirectory();
    final appBytes =
        await _getDirectorySize(appDir);

    final totalBytes =
        booksBytes + cacheBytes + appBytes;

    return {
      'booksSize': _formatBytes(booksBytes),
      'cacheSize': _formatBytes(cacheBytes),
      'appDataSize': _formatBytes(appBytes),
      'totalSize': _formatBytes(totalBytes),
      'booksPercent': totalBytes > 0
          ? booksBytes / totalBytes
          : 0.0,
      'cachePercent': totalBytes > 0
          ? cacheBytes / totalBytes
          : 0.0,
      'appDataPercent': totalBytes > 0
          ? appBytes / totalBytes
          : 0.0,
    };
  }

  // ──────────────────────────────────────────

  Future<int> _getDirectorySize(
    Directory dir,
  ) async {
    int size = 0;
    try {
      if (await dir.exists()) {
        await for (final entity in dir.list(
          recursive: true,
          followLinks: false,
        )) {
          if (entity is File) {
            size += await entity.length();
          }
        }
      }
    } catch (_) {}
    return size;
  }

  // ──────────────────────────────────────────

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // ──────────────────────────────────────────

  Future<void> _clearCache() async {
    final cacheDir = await getTemporaryDirectory();
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
      await cacheDir.create();
    }
    await DefaultCacheManager().emptyCache();
  }

  // ──────────────────────────────────────────

  Future<void> _exportData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Preparing your data...'),
          ],
        ),
      ),
    );

    try {
      final data = await context
          .read<ProfileBloc>()
          .exportUserData();

      if (mounted) Navigator.pop(context);

      await Share.shareXFiles(
        [XFile(data.path)],
        subject: 'BookNest Data Export',
      );
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _StorageRow
// ─────────────────────────────────────────────────────────────────────────────

class _StorageRow extends StatelessWidget {
  final String label;
  final String size;
  final Color color;
  final double percentage;

  const _StorageRow({
    required this.label,
    required this.size,
    required this.color,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              size,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade200,
            valueColor:
                AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _DeleteWarningItem
// ─────────────────────────────────────────────────────────────────────────────

class _DeleteWarningItem extends StatelessWidget {
  final String text;

  const _DeleteWarningItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.remove_circle,
            color: Colors.red.shade300,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}