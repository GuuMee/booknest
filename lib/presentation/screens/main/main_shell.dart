// lib/presentation/screens/main/main_shell.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Config - Theme
import '../../../config/theme/app_colors.dart';

// BLoC
import '../../bloc/theme/theme_bloc.dart';

// Kids Mode Screens (for kids bottom nav labels/icons)
import '../kids_mode/kids_home_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Nav item model
// ─────────────────────────────────────────────────────────────────────────────

class _NavItemData {
  final IconData icon;
  final String label;
  final String route;

  const _NavItemData({
    required this.icon,
    required this.label,
    required this.route,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Adult nav items
// ─────────────────────────────────────────────────────────────────────────────

const List<_NavItemData> _adultNavItems = [
  _NavItemData(
    icon: Icons.home_rounded,
    label: 'Home',
    route: '/home',
  ),
  _NavItemData(
    icon: Icons.library_books_rounded,
    label: 'Library',
    route: '/library',
  ),
  _NavItemData(
    icon: Icons.explore_rounded,
    label: 'Discover',
    route: '/discover',
  ),
  _NavItemData(
    icon: Icons.person_rounded,
    label: 'Profile',
    route: '/profile',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Kids nav items
// ─────────────────────────────────────────────────────────────────────────────

const List<_NavItemData> _kidsNavItems = [
  _NavItemData(
    icon: Icons.home_rounded,
    label: 'Home',
    route: '/kids/home',
  ),
  _NavItemData(
    icon: Icons.menu_book_rounded,
    label: 'Books',
    route: '/kids/books',
  ),
  _NavItemData(
    icon: Icons.star_rounded,
    label: 'Stars',
    route: '/kids/stars',
  ),
  _NavItemData(
    icon: Icons.celebration_rounded,
    label: 'Fun',
    route: '/kids/fun',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// MainShell — StatefulWidget to track kids mode from ThemeBloc
// ─────────────────────────────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool _isKidsMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is KidsModeState) {
          setState(() => _isKidsMode = state.isKidsMode);
        }
      },
      child: Scaffold(
        // ── AnimatedSwitcher gives a smooth fade when
        //    switching between kids/adult content
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: KeyedSubtree(
            key: ValueKey(_isKidsMode),
            child: widget.child,
          ),
        ),
        bottomNavigationBar: _BottomNav(
          isKidsMode: _isKidsMode,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Navigation Bar
// ─────────────────────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final bool isKidsMode;

  const _BottomNav({required this.isKidsMode});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final navItems = isKidsMode ? _kidsNavItems : _adultNavItems;

    // Find current index by matching route prefix
    int currentIndex = 0;
    for (int i = 0; i < navItems.length; i++) {
      if (location.startsWith(navItems[i].route)) {
        currentIndex = i;
        break;
      }
    }

    // Kids mode has a colorful background
    final backgroundColor = isKidsMode
        ? AppColors.kidsBlue.withOpacity(0.08)
        : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navItems.length,
              (index) => _NavItem(
                icon: navItems[index].icon,
                label: navItems[index].label,
                isSelected: currentIndex == index,
                isKidsMode: isKidsMode,
                onTap: () => context.go(navItems[index].route),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single Nav Item — animated pill style
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isKidsMode;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isKidsMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Kids mode uses a fun orange/yellow accent
    final activeColor =
        isKidsMode ? AppColors.kidsOrange : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Animated icon size for kids mode
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                color: isSelected
                    ? activeColor
                    : Colors.grey.shade400,
                size: isKidsMode ? 28 : 24,
              ),
            ),
            // ── Show label only when selected
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: activeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: isKidsMode ? 14 : 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}