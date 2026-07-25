// lib/presentation/screens/profile/tabs/reviews_tab.dart

import 'package:cached_network_image/cached_network_image.dart'; // CachedNetworkImage
import 'package:flutter/material.dart';                          // StatelessWidget, Widget
                                                                 // ListView, Container
                                                                 // Column, Row, Padding
                                                                 // BoxDecoration, ClipRRect
                                                                 // Colors, Icons
                                                                 // GestureDetector
                                                                 // showModalBottomSheet
                                                                 // showDialog, AlertDialog
import 'package:flutter_bloc/flutter_bloc.dart';                 // BlocBuilder, context.read

// Presentation - BLoC - Reviews
import '../../../bloc/reviews/reviews_bloc.dart';                // ReviewsBloc
import '../../../bloc/reviews/reviews_state.dart';               // ReviewsState
                                                                 // ReviewsLoading
                                                                 // ReviewsLoaded
import '../../../bloc/reviews/reviews_event.dart';               // DeleteReview

// Data - Models
import '../../../../data/models/review.dart';                    // Review

// Presentation - Widgets - Sheets
import '../../book/sheets/write_review_sheet.dart';              // WriteReviewSheet

// ─────────────────────────────────────────────────────────────────────────────
// TAB — ReviewsTab
// ─────────────────────────────────────────────────────────────────────────────

class _ReviewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReviewsLoaded && state.userReviews.isEmpty) {
          return _EmptyReviewsState();
        }

        if (state is ReviewsLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: state.userReviews.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Text(
                        '${state.userReviews.length} Reviews',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Avg: ${_calculateAverage(state.userReviews).toStringAsFixed(1)} ⭐',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final review = state.userReviews[index - 1];
              return _ReviewCard(review: review);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  double _calculateAverage(List<Review> reviews) {
    if (reviews.isEmpty) return 0;
    return reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        reviews.length;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _EmptyReviewsState
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyReviewsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('✍️', style: TextStyle(fontSize: 36)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Reviews Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Share your thoughts about the books you\'ve read',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _ReviewCard
// ─────────────────────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book info row
          Row(
            children: [
              // Book cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: review.bookCoverUrl ?? '',
                  width: 40,
                  height: 56,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Colors.grey.shade200,
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.book,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.bookTitle ?? 'Unknown Book',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.bookAuthor ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Rating
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Colors.amber.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (review.title != null && review.title!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.title!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],

          if (review.content != null && review.content!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.content!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: 12),

          // Bottom row
          Row(
            children: [
              Text(
                _formatDate(review.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              if (review.likesCount > 0) ...[
                Icon(
                  Icons.thumb_up_rounded,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(width: 4),
                Text(
                  '${review.likesCount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Edit button
              GestureDetector(
                onTap: () => _showEditReviewSheet(context, review),
                child: Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 12),

              // Delete button
              GestureDetector(
                onTap: () => _showDeleteConfirmation(context, review),
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 16,
                  color: Colors.red.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // ─────────────────────────────────────────
  // SHEETS & DIALOGS
  // ─────────────────────────────────────────

  void _showEditReviewSheet(BuildContext context, Review review) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return WriteReviewSheet(
          bookId: review.bookId,
          existingReview: review,
        );
      },
    );
  }

  // ──────────────────────────────────────────

  void _showDeleteConfirmation(BuildContext context, Review review) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Review',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Are you sure you want to delete this review?'
            ' This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              // ✅ Fixed broken syntax here
              onPressed: () {
                context.read<ReviewsBloc>().add(
                      DeleteReview(reviewId: review.id!),
                    );
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}