// lib/config/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';    // context.read
import 'package:go_router/go_router.dart';          // GoRouter, GoRoute, ShellRoute
import 'package:lottie/lottie.dart';                // Lottie.asset

// Data - Models
import '../../data/models/book_model.dart';
import '../../data/models/reading_progress_model.dart';

// Data - Enums
import '../../data/enums/subscription_tier.dart';

// Presentation - BLoC - Auth
import '../presentation/blocs/auth/auth_bloc.dart';
import '../presentation/blocs/auth/auth_state.dart';

// Presentation - Screens - Splash
import '../../presentation/screens/splash/splash_screen.dart';

// Presentation - Screens - Onboarding
import '../../presentation/screens/onboarding/onboarding_screen.dart';

// Presentation - Screens - Auth
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';

// Presentation - Shell
import '../../presentation/screens/shell/main_shell.dart';

// Presentation - Screens - Main Tabs
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/explore/explore_screen.dart';
import '../../presentation/screens/library/my_library_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';

// Presentation - Screens - Book
import '../../presentation/screens/book_detail/book_detail_screen.dart';

// Presentation - Screens - Reader
import '../../presentation/screens/reader/pdf_reader_screen.dart';

// Presentation - Screens - Subscription
import '../../presentation/screens/subscription/subscription_screen.dart';
import '../../presentation/screens/subscription/payment_screen.dart';

// Presentation - Screens - Kids
import '../../presentation/screens/kids/kids_pin_screen.dart';
import '../../presentation/screens/kids/kids_home_screen.dart';
import '../../presentation/screens/kids/kids_reader_screen.dart';
import '../../presentation/screens/kids/kids_rewards_screen.dart';

// Presentation - Screens - Notifications
import '../../presentation/screens/notifications/notifications_screen.dart';

// Presentation - Screens - Settings
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/settings/edit_profile_screen.dart';
import '../../presentation/screens/settings/parental_control_screen.dart';
import '../../presentation/screens/settings/downloads_management_screen.dart';
import '../../presentation/screens/settings/reading_reports_screen.dart';

// Core - Theme
import '../../core/theme/app_typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ROUTER
// ─────────────────────────────────────────────────────────────────────────────

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',

  // ─────────────────────────────────────────
  // REDIRECT GUARD
  // ─────────────────────────────────────────
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;

    final isOnSplash =
        state.matchedLocation == '/splash';
    final isOnAuthPage =
        state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/onboarding';

    // Always allow splash to render
    if (isOnSplash) return null;

    // Not authenticated
    if (authState is! Authenticated) {
      if (isOnAuthPage) return null;
      return '/onboarding';
    }

    // Authenticated but on auth pages → go home
    if (isOnAuthPage) return '/';

    return null;
  },

  // ─────────────────────────────────────────
  // ROUTES
  // ─────────────────────────────────────────
  routes: [
    // ── Splash ──────────────────────────────
    GoRoute(
      path: '/splash',
      builder: (context, state) =>
          const SplashScreen(),
    ),

    // ── Onboarding ──────────────────────────
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) =>
          CustomTransitionPage(
        child: const OnboardingScreen(),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),

    // ── Auth ────────────────────────────────
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) =>
          const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) =>
          const ForgotPasswordScreen(),
    ),

    // ── Main Shell (bottom nav) ──────────────
    ShellRoute(
      builder: (context, state, child) =>
          MainShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) =>
              const NoTransitionPage(
            child: ExploreScreen(),
          ),
        ),
        GoRoute(
          path: '/library',
          pageBuilder: (context, state) =>
              const NoTransitionPage(
            child: MyLibraryScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),

    // ── Book Detail ─────────────────────────
    GoRoute(
      path: '/book/:id',
      pageBuilder: (context, state) {
        final book = state.extra as BookModel?;
        final bookId =
            state.pathParameters['id']!;
        return CustomTransitionPage(
          child: BookDetailScreen(
            bookId: bookId,
            book: book,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),

    // ── PDF Reader ──────────────────────────
    GoRoute(
      path: '/reader/:bookId',
      pageBuilder: (context, state) {
        final data =
            state.extra as Map<String, dynamic>;
        return CustomTransitionPage(
          child: PdfReaderScreen(
            book: data['book'] as BookModel,
            existingProgress: data['progress']
                as ReadingProgressModel?,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),

    // ── Subscription ────────────────────────
    GoRoute(
      path: '/subscription',
      builder: (context, state) =>
          const SubscriptionScreen(),
      routes: [
        GoRoute(
          path: 'payment',
          builder: (context, state) {
            final plan =
                state.extra as SubscriptionTier;
            return PaymentScreen(
              selectedPlan: plan,
            );
          },
        ),
      ],
    ),

    // ── Kids Mode ───────────────────────────
    GoRoute(
      path: '/kids-mode',
      builder: (context, state) =>
          const KidsPinScreen(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) =>
              const KidsHomeScreen(),
        ),
        GoRoute(
          path: 'reader/:bookId',
          builder: (context, state) {
            final book =
                state.extra as BookModel;
            return KidsReaderScreen(book: book);
          },
        ),
        GoRoute(
          path: 'rewards',
          builder: (context, state) =>
              const KidsRewardsScreen(),
        ),
      ],
    ),

    // ── Notifications ───────────────────────
    GoRoute(
      path: '/notifications',
      builder: (context, state) =>
          const NotificationsScreen(),
    ),

    // ── Settings ────────────────────────────
    GoRoute(
      path: '/settings',
      builder: (context, state) =>
          const SettingsScreen(),
      routes: [
        GoRoute(
          path: 'edit-profile',
          builder: (context, state) =>
              const EditProfileScreen(),
        ),
        GoRoute(
          path: 'parental-controls',
          builder: (context, state) =>
              const ParentalControlScreen(),
        ),
        GoRoute(
          path: 'downloads',
          builder: (context, state) =>
              const DownloadsManagementScreen(),
        ),
        GoRoute(
          path: 'reading-reports',
          builder: (context, state) =>
              const ReadingReportsScreen(),
        ),
      ],
    ),
  ],

  // ─────────────────────────────────────────
  // ERROR PAGE
  // ─────────────────────────────────────────
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/404.json',
            width: 250,
          ),
          const SizedBox(height: 20),
          Text(
            'Page not found',
            style: AppTypography.heading2,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);