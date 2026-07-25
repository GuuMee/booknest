// lib/presentation/blocs/reviews/reviews_bloc.dart

import 'package:equatable/equatable.dart';                        // Equatable, props
import 'package:firebase_auth/firebase_auth.dart';                // FirebaseAuth
import 'package:flutter/foundation.dart';                         // debugPrint
import 'package:flutter_bloc/flutter_bloc.dart';                  // Bloc, Emitter

// Data - Models
import '../../../data/models/review.dart';                        // Review

// Data - Repositories
import '../../../data/repositories/review_repository.dart';       // ReviewRepository

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookReviews extends ReviewsEvent {
  final String bookId;

  const LoadBookReviews({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class LoadUserReviews extends ReviewsEvent {}

class SubmitReview extends ReviewsEvent {
  final Review review;

  const SubmitReview({required this.review});

  @override
  List<Object?> get props => [review];
}

class UpdateReview extends ReviewsEvent {
  final Review review;

  const UpdateReview({required this.review});

  @override
  List<Object?> get props => [review];
}

class DeleteReview extends ReviewsEvent {
  final String reviewId;

  const DeleteReview({required this.reviewId});

  @override
  List<Object?> get props => [reviewId];
}

class ToggleReviewLike extends ReviewsEvent {
  final String reviewId;

  const ToggleReviewLike({required this.reviewId});

  @override
  List<Object?> get props => [reviewId];
}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<Review> bookReviews;
  final List<Review> userReviews;
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  const ReviewsLoaded({
    this.bookReviews = const [],
    this.userReviews = const [],
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.ratingDistribution = const {},
  });

  ReviewsLoaded copyWith({
    List<Review>? bookReviews,
    List<Review>? userReviews,
    double? averageRating,
    int? totalReviews,
    Map<int, int>? ratingDistribution,
  }) {
    return ReviewsLoaded(
      bookReviews: bookReviews ?? this.bookReviews,
      userReviews: userReviews ?? this.userReviews,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      ratingDistribution: ratingDistribution ?? this.ratingDistribution,
    );
  }

  @override
  List<Object?> get props => [
        bookReviews,
        userReviews,
        averageRating,
        totalReviews,
      ];
}

class ReviewSubmitted extends ReviewsState {}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository _reviewRepository;
  final FirebaseAuth _auth;

  ReviewsBloc({
    required ReviewRepository reviewRepository,
    required FirebaseAuth auth,
  })  : _reviewRepository = reviewRepository,
        _auth = auth,
        super(ReviewsInitial()) {
    on<LoadBookReviews>(_onLoadBookReviews);
    on<LoadUserReviews>(_onLoadUserReviews);
    on<SubmitReview>(_onSubmitReview);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
    on<ToggleReviewLike>(_onToggleLike);
  }

  // ─────────────────────────────────────────
  // HANDLERS
  // ─────────────────────────────────────────

  Future<void> _onLoadBookReviews(
    LoadBookReviews event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(ReviewsLoading());

    try {
      final reviews =
          await _reviewRepository.getBookReviews(event.bookId);

      // Mark liked reviews
      final markedReviews = reviews.map((r) {
        return Review(
          id: r.id,
          bookId: r.bookId,
          userId: r.userId,
          userName: r.userName,
          userPhotoUrl: r.userPhotoUrl,
          bookTitle: r.bookTitle,
          bookAuthor: r.bookAuthor,
          bookCoverUrl: r.bookCoverUrl,
          rating: r.rating,
          title: r.title,
          content: r.content,
          likesCount: r.likesCount,
          isLikedByCurrentUser: false, // Would check from likes subcollection
          createdAt: r.createdAt,
          updatedAt: r.updatedAt,
        );
      }).toList();

      // Calculate average rating
      final avgRating = markedReviews.isEmpty
          ? 0.0
          : markedReviews
                  .map((r) => r.rating)
                  .reduce((a, b) => a + b) /
              markedReviews.length;

      // Calculate rating distribution
      final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
      for (final review in markedReviews) {
        final key = review.rating.round().clamp(1, 5);
        distribution[key] = (distribution[key] ?? 0) + 1;
      }

      final currentState = state;
      if (currentState is ReviewsLoaded) {
        emit(currentState.copyWith(
          bookReviews: markedReviews,
          averageRating: avgRating,
          totalReviews: markedReviews.length,
          ratingDistribution: distribution,
        ));
      } else {
        emit(ReviewsLoaded(
          bookReviews: markedReviews,
          averageRating: avgRating,
          totalReviews: markedReviews.length,
          ratingDistribution: distribution,
        ));
      }
    } catch (e) {
      emit(ReviewsError(message: 'Failed to load reviews: $e'));
    }
  }

  // ──────────────────────────────────────────

  Future<void> _onLoadUserReviews(
    LoadUserReviews event,
    Emitter<ReviewsState> emit,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      final reviews =
          await _reviewRepository.getUserReviews(userId);

      final currentState = state;
      if (currentState is ReviewsLoaded) {
        emit(currentState.copyWith(userReviews: reviews));
      } else {
        emit(ReviewsLoaded(userReviews: reviews));
      }
    } catch (e) {
      emit(ReviewsError(message: 'Failed to load your reviews: $e'));
    }
  }

  // ──────────────────────────────────────────

  Future<void> _onSubmitReview(
    SubmitReview event,
    Emitter<ReviewsState> emit,
  ) async {
    try {
      await _reviewRepository.addReview(event.review);
      emit(ReviewSubmitted());

      // Reload reviews
      add(LoadBookReviews(bookId: event.review.bookId));
      add(LoadUserReviews());
    } catch (e) {
      emit(ReviewsError(message: 'Failed to submit review: $e'));
    }
  }

  // ──────────────────────────────────────────

  Future<void> _onUpdateReview(
    UpdateReview event,
    Emitter<ReviewsState> emit,
  ) async {
    try {
      await _reviewRepository.updateReview(event.review);

      // Reload
      add(LoadBookReviews(bookId: event.review.bookId));
      add(LoadUserReviews());
    } catch (e) {
      emit(ReviewsError(message: 'Failed to update review: $e'));
    }
  }

  // ──────────────────────────────────────────

  Future<void> _onDeleteReview(
    DeleteReview event,
    Emitter<ReviewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ReviewsLoaded) return;

    try {
      await _reviewRepository.deleteReview(event.reviewId);

      final updatedUserReviews = currentState.userReviews
          .where((r) => r.id != event.reviewId)
          .toList();
      final updatedBookReviews = currentState.bookReviews
          .where((r) => r.id != event.reviewId)
          .toList();

      emit(currentState.copyWith(
        userReviews: updatedUserReviews,
        bookReviews: updatedBookReviews,
        totalReviews: updatedBookReviews.length,
      ));
    } catch (e) {
      emit(ReviewsError(message: 'Failed to delete review: $e'));
    }
  }

  // ──────────────────────────────────────────

  Future<void> _onToggleLike(
    ToggleReviewLike event,
    Emitter<ReviewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ReviewsLoaded) return;

    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      final updatedReviews =
          currentState.bookReviews.map((review) {
        if (review.id == event.reviewId) {
          final newLiked = !review.isLikedByCurrentUser;
          return review.copyWith(
            isLikedByCurrentUser: newLiked,
            likesCount:
                review.likesCount + (newLiked ? 1 : -1),
          );
        }
        return review;
      }).toList();

      emit(currentState.copyWith(bookReviews: updatedReviews));

      await _reviewRepository.toggleLike(event.reviewId, userId);
    } catch (e) {
      debugPrint('Failed to toggle like: $e');
    }
  }
}