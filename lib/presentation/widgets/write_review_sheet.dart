// lib/presentation/widgets/write_review_sheet.dart

import 'package:firebase_auth/firebase_auth.dart';                // FirebaseAuth
import 'package:flutter/material.dart';                           // StatefulWidget
                                                                  // StatelessWidget
                                                                  // TextEditingController
                                                                  // Widget, BuildContext
                                                                  // Column, Row, Padding
                                                                  // TextField, InputDecoration
                                                                  // ElevatedButton, SizedBox
                                                                  // CircularProgressIndicator
                                                                  // ScaffoldMessenger
                                                                  // SnackBar, Navigator
                                                                  // GestureDetector, Icon
                                                                  // Icons, Colors
import 'package:flutter_bloc/flutter_bloc.dart';                  // BlocListener
                                                                  // context.read

// Data - Models
import '../../data/models/review.dart';                           // Review

// Presentation - BLoC - Reviews
import '../blocs/reviews/reviews_bloc.dart';                      // ReviewsBloc
                                                                  // ReviewsState
                                                                  // ReviewSubmitted
                                                                  // ReviewsError
                                                                  // SubmitReview
                                                                  // UpdateReview

// Core - Theme
import '../../core/theme/app_colors.dart';                        // AppColors

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — WriteReviewSheet
// ─────────────────────────────────────────────────────────────────────────────

class WriteReviewSheet extends StatefulWidget {
  final String bookId;
  final Review? existingReview;
  final String? bookTitle;
  final String? bookAuthor;
  final String? bookCoverUrl;

  const WriteReviewSheet({
    super.key,
    required this.bookId,
    this.existingReview,
    this.bookTitle,
    this.bookAuthor,
    this.bookCoverUrl,
  });

  @override
  State<WriteReviewSheet> createState() => _WriteReviewSheetState();
}

// ─────────────────────────────────────────────────────────────────────────────
// STATE — _WriteReviewSheetState
// ─────────────────────────────────────────────────────────────────────────────

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  late double _rating;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _rating = widget.existingReview?.rating ?? 0.0;
    _titleController = TextEditingController(
      text: widget.existingReview?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.existingReview?.content ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              widget.existingReview != null
                  ? 'Edit Review'
                  : 'Write a Review',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),

            // ===== STAR RATING =====
            const Text(
              'Your Rating',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _StarRatingInput(
              rating: _rating,
              onChanged: (value) {
                setState(() => _rating = value);
              },
            ),
            const SizedBox(height: 20),

            // ===== REVIEW TITLE =====
            const Text(
              'Title (optional)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Summarize your experience',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 12),

            // ===== REVIEW CONTENT =====
            const Text(
              'Your Review',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Share your thoughts about this book...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              maxLines: 5,
              minLines: 3,
              maxLength: 1000,
            ),
            const SizedBox(height: 20),

            // ===== SUBMIT BUTTON =====
            BlocListener<ReviewsBloc, ReviewsState>(
              listener: (context, state) {
                if (state is ReviewSubmitted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.existingReview != null
                            ? 'Review updated!'
                            : 'Review submitted!',
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
                if (state is ReviewsError) {
                  setState(() => _isSubmitting = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _rating == 0 || _isSubmitting
                      ? null
                      : _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor:
                        Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.existingReview != null
                              ? 'Update Review'
                              : 'Submit Review',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // SUBMIT
  // ─────────────────────────────────────────

  void _submitReview() {
    setState(() => _isSubmitting = true);

    final user = FirebaseAuth.instance.currentUser;

    if (widget.existingReview != null) {
      context.read<ReviewsBloc>().add(
            UpdateReview(
              review: widget.existingReview!.copyWith(
                rating: _rating,
                title: _titleController.text.trim().isEmpty
                    ? null
                    : _titleController.text.trim(),
                content: _contentController.text.trim().isEmpty
                    ? null
                    : _contentController.text.trim(),
              ),
            ),
          );
    } else {
      context.read<ReviewsBloc>().add(
            SubmitReview(
              review: Review(
                bookId: widget.bookId,
                userId: user?.uid ?? '',
                userName: user?.displayName,
                userPhotoUrl: user?.photoURL,
                bookTitle: widget.bookTitle,
                bookAuthor: widget.bookAuthor,
                bookCoverUrl: widget.bookCoverUrl,
                rating: _rating,
                title: _titleController.text.trim().isEmpty
                    ? null
                    : _titleController.text.trim(),
                content: _contentController.text.trim().isEmpty
                    ? null
                    : _contentController.text.trim(),
                createdAt: DateTime.now(),
              ),
            ),
          );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET — _StarRatingInput
// ─────────────────────────────────────────────────────────────────────────────

class _StarRatingInput extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;

  const _StarRatingInput({
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starValue = index + 1.0;
        final isFilled = starValue <= rating;
        final isHalf = starValue - 0.5 == rating;

        return GestureDetector(
          onTap: () => onChanged(starValue),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              isFilled
                  ? Icons.star_rounded
                  : isHalf
                      ? Icons.star_half_rounded
                      : Icons.star_outline_rounded,
              color: isFilled || isHalf
                  ? Colors.amber.shade500
                  : Colors.grey.shade300,
              size: 42,
            ),
          ),
        );
      }),
    );
  }
}