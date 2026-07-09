// lib/presentation/screens/profile/profile_screen.dart

import 'package:flutter/material.dart';              // StatelessWidget, Widget, etc.
import 'package:flutter_bloc/flutter_bloc.dart';     // BlocBuilder, context.read<>()
import 'package:cached_network_image/cached_network_image.dart'; // CachedNetworkImageProvider
import 'package:go_router/go_router.dart';           // context.push()
import 'package:url_launcher/url_launcher.dart';     // canLaunchUrl, launchUrl

// Presentation - BLoC - Auth
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';            // Authenticated
import '../../bloc/auth/auth_event.dart';            // SignOutRequested

// Presentation - BLoC - Profile
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';      // ProfileLoaded
import '../../bloc/profile/profile_event.dart';      // SubmitFeedback

// Core - Theme
import '../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final user = authState is Authenticated
              ? authState.user
              : null;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Header ──────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    MediaQuery.of(context).padding.top +
                        20,
                    24,
                    24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withBlue(200),
                      ],
                    ),
                    borderRadius:
                        const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Top Bar
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight:
                                  FontWeight.w900,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons
                                      .notifications_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    context.push(
                                  '/notifications',
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons
                                      .settings_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    context.push(
                                  '/settings',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Profile Info
                      Row(
                        children: [
                          // Avatar
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              image: user?.avatarUrl !=
                                      null
                                  ? DecorationImage(
                                      image:
                                          CachedNetworkImageProvider(
                                        user!.avatarUrl!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: user?.avatarUrl ==
                                    null
                                ? Center(
                                    child: Text(
                                      (user?.name ??
                                              'U')[0]
                                          .toUpperCase(),
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.white,
                                        fontSize: 28,
                                        fontWeight:
                                            FontWeight
                                                .w800,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),

                          // Name & Email
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  user?.name ??
                                      'Guest User',
                                  style:
                                      const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user?.email ??
                                      'Sign in to sync your data',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.8),
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Subscription Badge
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(
                                            0.2),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                20),
                                  ),
                                  child: Text(
                                    user?.isPremium ==
                                            true
                                        ? '⭐ Premium Member'
                                        : '📖 Free Plan',
                                    style:
                                        const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Reading Stats
                      BlocBuilder<ProfileBloc,
                          ProfileState>(
                        builder:
                            (context, profileState) {
                          final stats =
                              profileState
                                      is ProfileLoaded
                                  ? profileState.stats
                                  : null;

                          return Row(
                            children: [
                              _ProfileStat(
                                value:
                                    '${stats?.booksRead ?? 0}',
                                label: 'Books Read',
                              ),
                              _ProfileStatDivider(),
                              _ProfileStat(
                                value:
                                    stats?.totalReadTime ??
                                        '0h',
                                label: 'Read Time',
                              ),
                              _ProfileStatDivider(),
                              _ProfileStat(
                                value:
                                    '${stats?.currentStreak ?? 0}',
                                label: 'Day Streak 🔥',
                              ),
                              _ProfileStatDivider(),
                              _ProfileStat(
                                value:
                                    '${stats?.totalPages ?? 0}',
                                label: 'Pages',
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // ── Menu Sections ────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // My Library
                      _SectionTitle(
                        title: 'My Library',
                      ),
                      const SizedBox(height: 12),
                      _MenuCard(
                        children: [
                          _MenuItem(
                            icon:
                                Icons.favorite_rounded,
                            iconColor: Colors.red,
                            title: 'Favorites',
                            onTap: () => context
                                .push('/favorites'),
                          ),
                          _MenuItem(
                            icon:
                                Icons.download_rounded,
                            iconColor: Colors.blue,
                            title: 'Downloads',
                            onTap: () => context
                                .push('/downloads'),
                          ),
                          _MenuItem(
                            icon:
                                Icons.bookmark_rounded,
                            iconColor: Colors.amber,
                            title: 'Bookmarks',
                            onTap: () => context.push(
                              '/all-bookmarks',
                            ),
                          ),
                          _MenuItem(
                            icon: Icons
                                .collections_bookmark_rounded,
                            iconColor: Colors.purple,
                            title: 'Collections',
                            onTap: () => context
                                .push('/collections'),
                          ),
                          _MenuItem(
                            icon: Icons.history_rounded,
                            iconColor: Colors.teal,
                            title: 'Reading History',
                            showDivider: false,
                            onTap: () =>
                                context.push('/history'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Goals & Achievements
                      _SectionTitle(
                        title: 'Goals & Achievements',
                      ),
                      const SizedBox(height: 12),
                      _MenuCard(
                        children: [
                          _MenuItem(
                            icon: Icons.flag_rounded,
                            iconColor: Colors.green,
                            title: 'Reading Goals',
                            onTap: () =>
                                context.push('/goals'),
                          ),
                          _MenuItem(
                            icon: Icons
                                .emoji_events_rounded,
                            iconColor: Colors.orange,
                            title: 'Achievements',
                            showDivider: false,
                            onTap: () => context
                                .push('/achievements'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Subscription
                      _SectionTitle(
                        title: 'Subscription',
                      ),
                      const SizedBox(height: 12),
                      _MenuCard(
                        children: [
                          _MenuItem(
                            icon: Icons.star_rounded,
                            iconColor:
                                Colors.amber.shade700,
                            title:
                                'Manage Subscription',
                            subtitle:
                                user?.isPremium == true
                                    ? 'Premium - Active'
                                    : 'Upgrade to Premium',
                            onTap: () => context
                                .push('/subscription'),
                          ),
                          _MenuItem(
                            icon: Icons
                                .receipt_long_rounded,
                            iconColor: Colors.indigo,
                            title: 'Purchase History',
                            showDivider: false,
                            onTap: () => context.push(
                              '/purchase-history',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Support & About
                      _SectionTitle(title: 'Support'),
                      const SizedBox(height: 12),
                      _MenuCard(
                        children: [
                          _MenuItem(
                            icon: Icons
                                .help_outline_rounded,
                            iconColor: Colors.cyan,
                            title: 'Help & FAQ',
                            onTap: () =>
                                context.push('/help'),
                          ),
                          _MenuItem(
                            icon:
                                Icons.feedback_outlined,
                            iconColor: Colors.pink,
                            title: 'Send Feedback',
                            onTap: () =>
                                _showFeedbackDialog(
                              context,
                            ),
                          ),
                          _MenuItem(
                            icon: Icons
                                .privacy_tip_outlined,
                            iconColor: Colors.grey,
                            title: 'Privacy Policy',
                            onTap: () => _openUrl(
                              'https://booknest.app/privacy',
                            ),
                          ),
                          _MenuItem(
                            icon: Icons
                                .description_outlined,
                            iconColor: Colors.grey,
                            title: 'Terms of Service',
                            onTap: () => _openUrl(
                              'https://booknest.app/terms',
                            ),
                          ),
                          _MenuItem(
                            icon: Icons
                                .info_outline_rounded,
                            iconColor: Colors.blueGrey,
                            title: 'About BookNest',
                            subtitle: 'Version 1.0.0',
                            showDivider: false,
                            onTap: () =>
                                _showAboutDialog(
                              context,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Sign Out
                      if (user != null)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _showSignOutDialog(
                              context,
                            ),
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                            ),
                            label: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            style:
                                OutlinedButton.styleFrom(
                              padding: const EdgeInsets
                                  .symmetric(
                                vertical: 14,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(16),
                              ),
                              side: BorderSide(
                                color:
                                    Colors.red.shade200,
                              ),
                            ),
                          ),
                        ),

                      // Sign In
                      if (user == null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                context.push('/login'),
                            icon: const Icon(
                              Icons.login_rounded,
                            ),
                            label:
                                const Text('Sign In'),
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primary,
                              foregroundColor:
                                  Colors.white,
                              padding: const EdgeInsets
                                  .symmetric(
                                vertical: 14,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(16),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to sign out?'
          ' Your offline books will still be available.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<AuthBloc>()
                  .add(SignOutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────

  void _showFeedbackDialog(BuildContext context) {
    final feedbackController = TextEditingController();
    String feedbackType = 'suggestion';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                MediaQuery.of(context)
                        .viewInsets
                        .bottom +
                    24,
              ),
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
                    'Send Feedback',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Feedback Type Chips
                  Row(
                    children: [
                      _FeedbackChip(
                        label: '💡 Suggestion',
                        isSelected:
                            feedbackType == 'suggestion',
                        onTap: () => setModalState(() =>
                            feedbackType = 'suggestion'),
                      ),
                      const SizedBox(width: 8),
                      _FeedbackChip(
                        label: '🐛 Bug Report',
                        isSelected:
                            feedbackType == 'bug',
                        onTap: () => setModalState(() =>
                            feedbackType = 'bug'),
                      ),
                      const SizedBox(width: 8),
                      _FeedbackChip(
                        label: '❤️ Praise',
                        isSelected:
                            feedbackType == 'praise',
                        onTap: () => setModalState(() =>
                            feedbackType = 'praise'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Message Input
                  TextField(
                    controller: feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Tell us what you think...',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (feedbackController.text
                            .trim()
                            .isNotEmpty) {
                          context
                              .read<ProfileBloc>()
                              .add(
                                SubmitFeedback(
                                  type: feedbackType,
                                  message:
                                      feedbackController
                                          .text
                                          .trim(),
                                ),
                              );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Thank you for your feedback! 💖',
                              ),
                              behavior:
                                  SnackBarBehavior
                                      .floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets
                            .symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Submit Feedback',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ──────────────────────────────────────────

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                'BookNest',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Version 1.0.0 (Build 1)',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your personal library for PDF books.'
                '\nRead anywhere, anytime.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () =>
                    Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────

  Future<void> _openUrl(String url) async {
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
// PRIVATE WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────

class _ProfileStatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }
}

// ──────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.grey.shade800,
      ),
    );
  }
}

// ──────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  final List<Widget> children;

  const _MenuCard({required this.children});

  @override
  Widget build(BuildContext context) {
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
}

// ──────────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final bool showDivider;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.showDivider = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 2,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
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
                  subtitle!,
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
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 76,
            endIndent: 20,
            color: Colors.grey.shade100,
          ),
      ],
    );
  }
}

// ──────────────────────────────────────────────

class _FeedbackChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FeedbackChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}