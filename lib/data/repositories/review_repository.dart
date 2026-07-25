// lib/data/repositories/review_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart'; // FirebaseFirestore
                                                       // CollectionReference
                                                       // FieldValue

// Data - Models
import '../models/review.dart';                        // Review

// ─────────────────────────────────────────────────────────────────────────────
// REPOSITORY — ReviewRepository
// ─────────────────────────────────────────────────────────────────────────────

class ReviewRepository {
  final FirebaseFirestore _firestore;

  ReviewRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _reviewsRef =>
      _firestore.collection('reviews');

  // ===== GET BOOK REVIEWS =====
  Future<List<Review>> getBookReviews(String bookId) async {
    final snapshot = await _reviewsRef
        .where('bookId', isEqualTo: bookId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Review.fromJson(data);
    }).toList();
  }

  // ===== GET USER REVIEWS =====
  Future<List<Review>> getUserReviews(String userId) async {
    final snapshot = await _reviewsRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Review.fromJson(data);
    }).toList();
  }

  // ===== ADD REVIEW =====
  Future<String> addReview(Review review) async {
    final docRef = await _reviewsRef.add(review.toJson());

    // Update book average rating
    await _updateBookRating(review.bookId);

    return docRef.id;
  }

  // ===== UPDATE REVIEW =====
  Future<void> updateReview(Review review) async {
    if (review.id == null) return;

    await _reviewsRef.doc(review.id).update({
      'rating': review.rating,
      'title': review.title,
      'content': review.content,
      'updatedAt': DateTime.now().toIso8601String(),
    });

    await _updateBookRating(review.bookId);
  }

  // ===== DELETE REVIEW =====
  Future<void> deleteReview(String reviewId) async {
    final doc = await _reviewsRef.doc(reviewId).get();
    final data = doc.data() as Map<String, dynamic>?;
    final bookId = data?['bookId'];

    await _reviewsRef.doc(reviewId).delete();

    if (bookId != null) {
      await _updateBookRating(bookId);
    }
  }

  // ===== TOGGLE LIKE =====
  Future<void> toggleLike(String reviewId, String userId) async {
    final likeRef = _reviewsRef
        .doc(reviewId)
        .collection('likes')
        .doc(userId);

    final likeDoc = await likeRef.get();

    if (likeDoc.exists) {
      await likeRef.delete();
      await _reviewsRef.doc(reviewId).update({
        'likesCount': FieldValue.increment(-1),
      });
    } else {
      await likeRef.set({
        'userId': userId,
        'createdAt': DateTime.now().toIso8601String(),
      });
      await _reviewsRef.doc(reviewId).update({
        'likesCount': FieldValue.increment(1),
      });
    }
  }

  // ===== UPDATE BOOK RATING =====
  Future<void> _updateBookRating(String bookId) async {
    final reviews = await getBookReviews(bookId);

    if (reviews.isEmpty) {
      await _firestore.collection('books').doc(bookId).update({
        'averageRating': 0.0,
        'reviewCount': 0,
      });
      return;
    }

    final avgRating =
        reviews.map((r) => r.rating).reduce((a, b) => a + b) /
            reviews.length;

    await _firestore.collection('books').doc(bookId).update({
      'averageRating':
          double.parse(avgRating.toStringAsFixed(1)),
      'reviewCount': reviews.length,
    });
  }

  // ===== CHECK IF USER REVIEWED =====
  Future<Review?> getUserReviewForBook(
    String bookId,
    String userId,
  ) async {
    final snapshot = await _reviewsRef
        .where('bookId', isEqualTo: bookId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final data =
        snapshot.docs.first.data() as Map<String, dynamic>;
    data['id'] = snapshot.docs.first.id;
    return Review.fromJson(data);
  }
}