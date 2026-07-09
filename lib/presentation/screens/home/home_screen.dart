// lib/presentation/screens/home/home_screen.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../data/models/book_model.dart';
import '../../bloc/books/books_bloc.dart';
import '../../../presentation/widgets/book_card.dart';
import 'widgets/continue_reading_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BooksBloc>().add(LoadHomeData());
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '☀️';
    if (hour < 17) return '🌤️';
    return '🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state is BooksLoading) {
              return _buildShimmerLoading();
            }
            if (state is BooksError) {
              return _buildError(state.message);
            }
            if (state is BooksLoaded) {
              return _buildContent(state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BooksLoaded state) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        context.read<BooksBloc>().add(LoadHomeData());
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ===== GREETING HEADER =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getGreeting()}, Sarah! ${_getGreetingEmoji()}',
                          style: AppTypography.heading2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What will you read today?',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification Bell
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push('/notifications');
                        },
                        icon: const Icon(
                          Icons.notifications_outlined,
                          size: 28,
                        ),
                      ),
                      // Unread Badge
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),

          // ===== SEARCH BAR =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: GestureDetector(
                onTap: () => context.push('/explore'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Search books, authors...',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.tune_rounded,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          ),

          // ===== CONTINUE READING =====
          if (state.currentlyReading != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ContinueReadingCard(
                  book: state.currentlyReading!.book,
                  progress: state.currentlyReading!.progress,
                  onTap: () {
                    context.push(
                      '/reader',
                      extra: state.currentlyReading!.book,
                    );
                  },
                ),
              ),
            ),

          // ===== CATEGORIES =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Categories',
                      style: AppTypography.heading3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ActionChip(
                            label: Text('${category.emoji} ${category.name}'),
                            backgroundColor: AppColors.primary.withOpacity(0.08),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            onPressed: () {
                              context.push(
                                '/explore',
                                extra: {'category': category.id},
                              );
                            },
                          ),
                        ).animate().fadeIn(
                          delay: Duration(milliseconds: 50 * index),
                          duration: 300.ms,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== TRENDING NOW =====
          SliverToBoxAdapter(
            child: _buildBookSection(
              title: '🔥 Trending Now',
              books: state.trendingBooks,
              onSeeAll: () => context.push('/explore?sort=trending'),
            ),
          ),

          // ===== RECOMMENDED =====
          SliverToBoxAdapter(
            child: _buildBookSection(
              title: '⭐ Recommended For You',
              books: state.recommendedBooks,
              onSeeAll: () => context.push('/explore?sort=recommended'),
            ),
          ),

          // ===== NEW ARRIVALS =====
          SliverToBoxAdapter(
            child: _buildBookSection(
              title: '🆕 New Arrivals',
              books: state.newArrivals,
              onSeeAll: () => context.push('/explore?sort=newest'),
            ),
          ),

          // ===== KIDS CORNER (if has kids profiles) =====
          SliverToBoxAdapter(
            child: _buildKidsCorner(state.kidsBooks),
          ),

          // ===== FREE BOOKS =====
          SliverToBoxAdapter(
            child: _buildBookSection(
              title: '🆓 Free Books',
              books: state.freeBooks,
              onSeeAll: () => context.push('/explore?filter=free'),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildBookSection({
    required String title,
    required List<BookModel> books,
    required VoidCallback onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.heading3),
                TextButton(
                  onPressed: onSeeAll,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Book List
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: books[index],
                  onTap: () {
                    context.push(
                      '/book/${books[index].id}',
                      extra: books[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKidsCorner(List<BookModel> kidsBooks) {
    if (kidsBooks.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 28, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.kidsGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🧒 Kids Corner',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push('/kids-mode'),
                child: const Text(
                  'Enter →',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Fun & safe books for your little ones!',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kidsBooks.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: kidsBooks[index].coverImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 180,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Search Bar Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Continue Reading Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Book Section Shimmer
          ...List.generate(3, (sectionIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 160,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (_, __) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 14,
                                  width: 120,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 80,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/error.json',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Something went wrong',
              style: AppTypography.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<BooksBloc>().add(LoadHomeData());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}