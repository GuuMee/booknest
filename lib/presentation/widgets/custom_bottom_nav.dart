// lib/presentation/widgets/custom_bottom_nav.dart

import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isKidsMode;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isKidsMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = isKidsMode
        ? const [
            _NavItem(icon: Icons.home_rounded, label: 'Home', emoji: '🏠'),
            _NavItem(icon: Icons.auto_stories_rounded, label: 'Books', emoji: '📚'),
            _NavItem(icon: Icons.star_rounded, label: 'Stars', emoji: '⭐'),
            _NavItem(icon: Icons.games_rounded, label: 'Fun', emoji: '🎮'),
          ]
        : const [
            _NavItem(icon: Icons.home_rounded, label: 'Home', emoji: '🏠'),
            _NavItem(icon: Icons.explore_rounded, label: 'Explore', emoji: '🔍'),
            _NavItem(icon: Icons.local_library_rounded, label: 'Library', emoji: '📚'),
            _NavItem(icon: Icons.person_rounded, label: 'Profile', emoji: '👤'),
          ];

    final selectedColor = isKidsMode ? AppColors.kidsBlue : AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = currentIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 14 : 10,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? selectedColor.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          items[index].emoji,
                          style: TextStyle(
                            fontSize: isKidsMode ? 18 : 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          items[index].icon,
                          color: isSelected ? selectedColor : Colors.grey,
                          size: isKidsMode ? 28 : 24,
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Text(
                            items[index].label,
                            style: TextStyle(
                              color: selectedColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isKidsMode ? 14 : 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String emoji;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.emoji,
  });
}