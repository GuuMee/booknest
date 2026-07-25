// lib/presentation/screens/reader/widgets/reader_settings_sheet.dart

import 'package:flutter/material.dart';              // StatefulWidget, State
                                                      // StatelessWidget
                                                      // Widget, BuildContext
                                                      // VoidCallback
                                                      // ValueChanged<T>
                                                      // Color, Colors
                                                      // Padding, EdgeInsets
                                                      // MediaQuery
                                                      // Column, Row
                                                      // MainAxisSize
                                                      // Container, Center
                                                      // BoxDecoration
                                                      // BoxShadow
                                                      // BorderRadius
                                                      // Border, BoxShape
                                                      // SizedBox, Spacer
                                                      // Expanded, Slider
                                                      // GestureDetector
                                                      // Text, TextStyle
                                                      // FontWeight
                                                      // Icon, Icons

// Domain - Models
import '../../../../domain/models/app_settings.dart'; // AppSettings
                                                      // .fontSize
                                                      // .lineSpacing
                                                      // .readingTheme
                                                      // .keepScreenOn
                                                      // .copyWith()

// Core - Theme
import '../../../../core/theme/app_colors.dart';      // AppColors.primary

// ─────────────────────────────────────────────────────────────────────────────

class _ReaderSettingsSheet extends StatefulWidget {
  final AppSettings settings;
  final ValueChanged<AppSettings> onSettingsChanged;

  const _ReaderSettingsSheet({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  State<_ReaderSettingsSheet> createState() =>
      _ReaderSettingsSheetState();
}

class _ReaderSettingsSheetState
    extends State<_ReaderSettingsSheet> {
  late AppSettings _settings;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  void _updateSettings(AppSettings newSettings) {
    setState(() => _settings = newSettings);
    widget.onSettingsChanged(newSettings);
  }

  Color _getPreviewBg() {
    switch (_settings.readingTheme) {
      case 'sepia':
        return const Color(0xFFF5E6C8);
      case 'dark':
        return const Color(0xFF1A1A2E);
      case 'amoled':
        return Colors.black;
      default:
        return Colors.grey.shade50;
    }
  }

  Color _getPreviewTextColor() {
    switch (_settings.readingTheme) {
      case 'sepia':
        return const Color(0xFF5B4636);
      case 'dark':
        return const Color(0xFFE0E0E0);
      case 'amoled':
        return Colors.white70;
      default:
        return Colors.black87;
    }
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
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
            'Reading Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),

          // ===== FONT SIZE =====
          Row(
            children: [
              Icon(
                Icons.text_fields_rounded,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              const Text(
                'Font Size',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${_settings.fontSize.toInt()}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'A',
                style: TextStyle(fontSize: 12),
              ),
              Expanded(
                child: Slider(
                  value: _settings.fontSize,
                  min: 12,
                  max: 28,
                  divisions: 16,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    _updateSettings(
                      _settings.copyWith(
                        fontSize: value,
                      ),
                    );
                  },
                ),
              ),
              const Text(
                'A',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ===== LINE SPACING =====
          Row(
            children: [
              Icon(
                Icons.format_line_spacing_rounded,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              const Text(
                'Line Spacing',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [1.0, 1.25, 1.5, 1.75, 2.0]
                .map((spacing) {
              final isSelected =
                  _settings.lineSpacing == spacing;
              return Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _updateSettings(
                        _settings.copyWith(
                          lineSpacing: spacing,
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${spacing}x',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w700,
                            fontSize: 12,
                            color: isSelected
                                ? Colors.white
                                : Colors
                                    .grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // ===== READING THEME =====
          Row(
            children: [
              Icon(
                Icons.palette_rounded,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              const Text(
                'Theme',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ThemeCircle(
                color: Colors.white,
                borderColor: Colors.grey.shade300,
                label: 'Light',
                isSelected:
                    _settings.readingTheme == 'light',
                onTap: () {
                  _updateSettings(
                    _settings.copyWith(
                      readingTheme: 'light',
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              _ThemeCircle(
                color: const Color(0xFFF5E6C8),
                borderColor:
                    const Color(0xFFD4B896),
                label: 'Sepia',
                isSelected:
                    _settings.readingTheme == 'sepia',
                onTap: () {
                  _updateSettings(
                    _settings.copyWith(
                      readingTheme: 'sepia',
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              _ThemeCircle(
                color: const Color(0xFF1A1A2E),
                borderColor:
                    const Color(0xFF2A2A4E),
                label: 'Dark',
                isSelected:
                    _settings.readingTheme == 'dark',
                onTap: () {
                  _updateSettings(
                    _settings.copyWith(
                      readingTheme: 'dark',
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              _ThemeCircle(
                color: Colors.black,
                borderColor: Colors.grey.shade800,
                label: 'AMOLED',
                isSelected:
                    _settings.readingTheme ==
                        'amoled',
                onTap: () {
                  _updateSettings(
                    _settings.copyWith(
                      readingTheme: 'amoled',
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ===== FONT PREVIEW =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _getPreviewBg(),
              borderRadius:
                  BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Text(
              'The quick brown fox jumps over the lazy dog. '
              'Reading is to the mind what exercise is to the body.',
              style: TextStyle(
                fontSize: _settings.fontSize,
                height: _settings.lineSpacing,
                color: _getPreviewTextColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ThemeCircle extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCircle({
    required this.color,
    required this.borderColor,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : borderColor,
                  width: isSelected ? 3 : 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary
                              .withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: color.computeLuminance() >
                              0.5
                          ? AppColors.primary
                          : Colors.white,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}