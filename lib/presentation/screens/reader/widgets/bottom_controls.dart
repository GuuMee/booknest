// lib/presentation/screens/reader/widgets/bottom_controls.dart

import 'package:flutter/material.dart';          // StatelessWidget
                                                  // Widget, BuildContext
                                                  // VoidCallback
                                                  // ValueChanged<double>
                                                  // Color, Colors
                                                  // Container, BoxDecoration
                                                  // BoxShadow, Offset
                                                  // SafeArea, Padding
                                                  // EdgeInsets
                                                  // Column, Row
                                                  // MainAxisSize
                                                  // MainAxisAlignment
                                                  // Text, TextStyle
                                                  // FontWeight
                                                  // TextOverflow
                                                  // SizedBox
                                                  // SliderTheme
                                                  // SliderThemeData
                                                  // RoundSliderThumbShape
                                                  // Slider
                                                  // Icon, Icons, IconData
                                                  // GestureDetector

import 'package:share_plus/share_plus.dart';     // Share.share()

// ─────────────────────────────────────────────────────────────────────────────

class _BottomControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final double progress;
  final String chapterTitle;
  final int secondsRead;
  final VoidCallback onSettingsTap;
  final ValueChanged<double> onSliderChanged;
  final Color backgroundColor;
  final Color textColor;
  final Color accentColor;

  const _BottomControls({
    required this.currentPage,
    required this.totalPages,
    required this.progress,
    required this.chapterTitle,
    required this.secondsRead,
    required this.onSettingsTap,
    required this.onSliderChanged,
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
  });

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Chapter title
              Text(
                chapterTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(
                    0.5,
                  ),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Slider
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: accentColor,
                  inactiveTrackColor:
                      textColor.withOpacity(0.1),
                  thumbColor: accentColor,
                  overlayColor:
                      accentColor.withOpacity(0.1),
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                ),
                child: Slider(
                  value: progress.clamp(0.0, 1.0),
                  onChanged: onSliderChanged,
                ),
              ),

              // Info row
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  // Page info
                  Text(
                    '$currentPage / $totalPages',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(
                        0.5,
                      ),
                    ),
                  ),

                  // Session time
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: textColor.withOpacity(
                          0.4,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(secondsRead),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textColor.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Percentage
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Action buttons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  _ControlButton(
                    icon: Icons.text_fields_rounded,
                    label: 'Font',
                    onTap: onSettingsTap,
                    color: textColor,
                  ),
                  _ControlButton(
                    icon:
                        Icons.brightness_6_rounded,
                    label: 'Theme',
                    onTap: onSettingsTap,
                    color: textColor,
                  ),
                  _ControlButton(
                    icon: Icons
                        .format_line_spacing_rounded,
                    label: 'Spacing',
                    onTap: onSettingsTap,
                    color: textColor,
                  ),
                  _ControlButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    onTap: () {
                      Share.share(
                        'I\'m reading "${chapterTitle}" - Page $currentPage',
                      );
                    },
                    color: textColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: color.withOpacity(0.7),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}