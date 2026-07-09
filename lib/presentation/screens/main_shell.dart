// lib/presentation/screens/main_shell.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Screens
import 'home/home_screen.dart';
import 'explore/explore_screen.dart';
import 'library/my_library_screen.dart';
import 'profile/profile_screen.dart';
import 'kids_mode/kids_home_screen.dart';

// BLoC
import '../bloc/theme/theme_bloc.dart';

// Widgets
import '../../../presentation/widgets/custom_bottom_nav.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  bool _isKidsMode = false;

  final List<Widget> _adultScreens = const [
    HomeScreen(),
    ExploreScreen(),
    MyLibraryScreen(),
    ProfileScreen(),
  ];

  final List<Widget> _kidsScreens = const [
    KidsHomeScreen(),
    KidsBookScreen(),
    KidsStarsScreen(),
    KidsFunScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is KidsModeState) {
          setState(() => _isKidsMode = state.isKidsMode);
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isKidsMode
              ? _kidsScreens[_currentIndex]
              : _adultScreens[_currentIndex],
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          isKidsMode: _isKidsMode,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}