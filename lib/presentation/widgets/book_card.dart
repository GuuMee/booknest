// lib/presentation/widgets/book_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/models/book_model.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  /// Прогресс чтения от 0.0 до 1.0.
  /// Если null — полоска прогресса не показывается.
  final double? progress;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
    this.progress,
  });

  /// Показывать ли полоску прогресса
  bool get _showProgress => progress != null;

  /// Безопасное значение прогресса в диапазоне [0.0, 1.0]
  double get _safeProgress => (progress ?? 0.0).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Book Cover with Hero Animation ─────────────
            Hero(
              tag: 'book-cover-${book.id}',
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: book.coverImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (_, __) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(color: Colors.grey),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.grey,
                            size: 32,
                          ),
                        ),
                      ),

                      // Premium Badge
                      if (book.isPremium)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.premiumGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '⭐ PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      // Downloaded indicator
                      if (book.isDownloaded)
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.download_done,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ─── Title ──────────────────────────────────────
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),

            // ─── Author ─────────────────────────────────────
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: Colors.grey,
              ),
            ),

            // ─── Rating ─────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  book.ratingLabel, // ✅ используем геттер из модели
                  style: AppTypography.bodySmall,
                ),
              ],
            ),

            // ─── Progress bar (если передан progress) ───────
            if (_showProgress) ...[
              const SizedBox(height: 6),
              LinearPercentIndicator(
                lineHeight: 4,
                percent: _safeProgress,
                backgroundColor: Colors.grey.shade200,
                progressColor: AppColors.primary,
                barRadius: const Radius.circular(4),
                padding: EdgeInsets.zero,
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}