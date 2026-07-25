// lib/data/models/review.dart

import 'package:equatable/equatable.dart'; // Equatable, props

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — Review
// ─────────────────────────────────────────────────────────────────────────────

class Review extends Equatable {
  final String? id;
  final String bookId;
  final String userId;
  final String? userName;
  final String? userPhotoUrl;
  final String? bookTitle;
  final String? bookAuthor;
  final String? bookCoverUrl;
  final double rating;
  final String? title;
  final String? content;
  final int likesCount;
  final bool isLikedByCurrentUser;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Review({
    this.id,
    required this.bookId,
    required this.userId,
    this.userName,
    this.userPhotoUrl,
    this.bookTitle,
    this.bookAuthor,
    this.bookCoverUrl,
    required this.rating,
    this.title,
    this.content,
    this.likesCount = 0,
    this.isLikedByCurrentUser = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookId: json['bookId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'],
      userPhotoUrl: json['userPhotoUrl'],
      bookTitle: json['bookTitle'],
      bookAuthor: json['bookAuthor'],
      bookCoverUrl: json['bookCoverUrl'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      title: json['title'],
      content: json['content'],
      likesCount: json['likesCount'] ?? 0,
      isLikedByCurrentUser: json['isLikedByCurrentUser'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'userId': userId,
        'userName': userName,
        'userPhotoUrl': userPhotoUrl,
        'bookTitle': bookTitle,
        'bookAuthor': bookAuthor,
        'bookCoverUrl': bookCoverUrl,
        'rating': rating,
        'title': title,
        'content': content,
        'likesCount': likesCount,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  Review copyWith({
    double? rating,
    String? title,
    String? content,
    int? likesCount,
    bool? isLikedByCurrentUser,
  }) {
    return Review(
      id: id,
      bookId: bookId,
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      bookTitle: bookTitle,
      bookAuthor: bookAuthor,
      bookCoverUrl: bookCoverUrl,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      content: content ?? this.content,
      likesCount: likesCount ?? this.likesCount,
      isLikedByCurrentUser:
          isLikedByCurrentUser ?? this.isLikedByCurrentUser,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        bookId,
        userId,
        rating,
        content,
      ];
}