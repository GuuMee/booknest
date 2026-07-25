// lib/presentation/screens/splash/splash_screen.dart

import 'package:flutter/material.dart';             // StatefulWidget
                                                    // State
                                                    // SingleTickerProviderStateMixin
                                                    // AnimationController
                                                    // Animation
                                                    // CurvedAnimation
                                                    // Tween
                                                    // Interval
                                                    // Curves
                                                    // AnimatedBuilder
                                                    // FadeTransition
                                                    // ScaleTransition
                                                    // Scaffold
                                                    // Container
                                                    // BoxDecoration
                                                    // LinearGradient
                                                    // Alignment
                                                    // Colors
                                                    // BorderRadius
                                                    // BoxShadow
                                                    // Offset
                                                    // Icon
                                                    // Icons
                                                    // SizedBox
                                                    // Text
                                                    // TextStyle
                                                    // FontWeight
                                                    // Column
                                                    // MainAxisAlignment
                                                    // Duration
                                                    // Widget
                                                    // BuildContext

import 'package:flutter_bloc/flutter_bloc.dart';    // context.read()

import 'package:go_router/go_router.dart';          // context.go()

// Presentation - BLoC - Auth
import '../../blocs/auth/auth_bloc.dart';           // AuthBloc
import '../../blocs/auth/auth_state.dart';          // AuthAuthenticated

// Core - Theme
import '../../../core/theme/app_colors.dart';       // AppColors
                                                    // .primary

// ─────────────────────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1500),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.easeOut,
        ),
      ),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.elasticOut,
        ),
      ),
    );

    _controller.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
        const Duration(seconds: 2));

    if (!mounted) return;

    final authState =
        context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withBlue(200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                                24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2),
                            blurRadius: 30,
                            offset:
                                const Offset(
                                    0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons
                            .auto_stories_rounded,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'BookNest',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Your Reading Companion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                          .withOpacity(0.8),
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}