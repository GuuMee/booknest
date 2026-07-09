// lib/presentation/screens/reader/widgets/reader_display_settings.dart

import 'package:flutter/material.dart';           // StatelessWidget, Widget, etc.
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // PdfScrollDirection

// Core - Theme
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MAIN WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class ReaderDisplaySettings extends StatelessWidget {
  final String currentTheme;
  final double brightness;
  final PdfScrollDirection scrollDirection;
  final bool keepScreenOn;
  final Function(String) onThemeChanged;
  final Function(double) onBrightnessChanged;
  final Function(PdfScrollDirection) onScrollDirectionChanged;
  final Function(bool) onKeepScreenOnChanged;

  const ReaderDisplaySettings({
    super.key,
    required this.currentTheme,
    required this.brightness,
    required this.scrollDirection,
    required this.keepScreenOn,
    required this.onThemeChanged,
    required this.onBrightnessChanged,
    required this.onScrollDirectionChanged,
    required this.onKeepScreenOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle ──────────────────────────
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

          Text(
            'Display Settings',
            style: AppTypography.heading3,
          ),
          const SizedBox(height: 24),

          // ── Background Theme ─────────────────
          Text(
            'Background',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ThemeOption(
                label: 'Light',
                color: Colors.white,
                textColor: Colors.black,
                isSelected: currentTheme == 'light',
                onTap: () => onThemeChanged('light'),
              ),
              const SizedBox(width: 12),
              _ThemeOption(
                label: 'Sepia',
                color: AppColors.sepiaBackground,
                textColor: Colors.brown.shade800,
                isSelected: currentTheme == 'sepia',
                onTap: () => onThemeChanged('sepia'),
              ),
              const SizedBox(width: 12),
              _ThemeOption(
                label: 'Dark',
                color: AppColors.darkReaderBg,
                textColor: Colors.white,
                isSelected: currentTheme == 'dark',
                onTap: () => onThemeChanged('dark'),
              ),
              const SizedBox(width: 12),
              _ThemeOption(
                label: 'Night',
                color: Colors.black,
                textColor: Colors.green.shade200,
                isSelected: currentTheme == 'night',
                onTap: () => onThemeChanged('night'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Brightness ───────────────────────
          Text(
            'Brightness',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.brightness_low,
                size: 20,
              ),
              Expanded(
                child: Slider(
                  value: brightness,
                  min: 0.3,
                  max: 1.0,
                  activeColor: AppColors.primary,
                  onChanged: onBrightnessChanged,
                ),
              ),
              const Icon(
                Icons.brightness_high,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Scroll Direction ─────────────────
          Text(
            'Scroll Direction',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DirectionOption(
                  icon: Icons.swap_vert_rounded,
                  label: 'Vertical',
                  isSelected: scrollDirection ==
                      PdfScrollDirection.vertical,
                  onTap: () =>
                      onScrollDirectionChanged(
                    PdfScrollDirection.vertical,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DirectionOption(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Horizontal',
                  isSelected: scrollDirection ==
                      PdfScrollDirection.horizontal,
                  onTap: () =>
                      onScrollDirectionChanged(
                    PdfScrollDirection.horizontal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Keep Screen On ───────────────────
          SwitchListTile(
            title: const Text('Keep Screen On'),
            subtitle: const Text(
              'Prevent screen from dimming',
            ),
            value: keepScreenOn,
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            onChanged: onKeepScreenOnChanged,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _ThemeOption
// ─────────────────────────────────────────────────────────────────────────────

class _ThemeOption extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.color,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey.shade300,
              width: isSelected ? 2.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _DirectionOption
// ─────────────────────────────────────────────────────────────────────────────

class _DirectionOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DirectionOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.primary
                    : Colors.grey.shade700,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}