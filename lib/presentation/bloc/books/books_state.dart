// lib/presentation/bloc/books/books_state.dart

import 'package:equatable/equatable.dart';

// Models
import '../../../data/models/book_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/reading_progress_model.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object?> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final CurrentlyReading? currentlyReading;
  final List<CategoryModel> categories;
  final List<BookModel> trendingBooks;
  final List<BookModel> recommendedBooks;
  final List<BookModel> newArrivals;
  final List<BookModel> freeBooks;
  final List<BookModel> kidsBooks;

  const BooksLoaded({
    this.currentlyReading,
    required this.categories,
    required this.trendingBooks,
    required this.recommendedBooks,
    required this.newArrivals,
    required this.freeBooks,
    required this.kidsBooks,
  });

  @override
  List<Object?> get props => [
        currentlyReading,
        categories,
        trendingBooks,
        recommendedBooks,
        newArrivals,
        freeBooks,
        kidsBooks,
      ];
}

class BooksError extends BooksState {
  final String message;

  const BooksError({required this.message});

  @override
  List<Object?> get props => [message];
}

class BookSearchResults extends BooksState {
  final List<BookModel> results;
  final String query;
  final bool hasMore;
  final int totalResults;

  const BookSearchResults({
    required this.results,
    required this.query,
    required this.hasMore,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [results, query, hasMore, totalResults];
}

class BookDownloading extends BooksState {
  final String bookId;
  final double progress;

  const BookDownloading({
    required this.bookId,
    required this.progress,
  });

  @override
  List<Object?> get props => [bookId, progress];
}

class BookDownloaded extends BooksState {
  final String bookId;
  final String localPath;

  const BookDownloaded({
    required this.bookId,
    required this.localPath,
  });

  @override
  List<Object?> get props => [bookId, localPath];
}

class CurrentlyReading {
  final BookModel book;
  final ReadingProgressModel progress;

  const CurrentlyReading({
    required this.book,
    required this.progress,
  });
}