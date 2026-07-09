// lib/presentation/bloc/books/books_bloc.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Models
import '../../../data/models/book_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/reading_progress_model.dart';

// Repositories
import '../../../domain/repositories/book_repository.dart';
//import '../../../domain/repositories/reading_progress_repository.dart';

// Use Cases
import '../../../domain/usecases/get_books.dart';
import '../../../domain/usecases/search_books.dart';
import '../../../domain/usecases/download_book.dart';
import '../../../domain/usecases/toggle_favorite.dart';
import '../../../domain/usecases/update_reading_progress.dart';

// ===== EVENTS =====
abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends BooksEvent {}

class SearchBooks extends BooksEvent {
  final String query;
  final Map<String, dynamic>? filters;

  const SearchBooks({required this.query, this.filters});

  @override
  List<Object?> get props => [query, filters];
}

class LoadBooksByCategory extends BooksEvent {
  final String categoryId;
  final int page;

  const LoadBooksByCategory({
    required this.categoryId,
    this.page = 1,
  });

  @override
  List<Object?> get props => [categoryId, page];
}

class DownloadBook extends BooksEvent {
  final BookModel book;

  const DownloadBook({required this.book});

  @override
  List<Object?> get props => [book];
}

class ToggleFavorite extends BooksEvent {
  final String bookId;

  const ToggleFavorite({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class LoadMoreBooks extends BooksEvent {
  final String section; // trending, recommended, new, free
  final int page;

  const LoadMoreBooks({required this.section, required this.page});

  @override
  List<Object?> get props => [section, page];
}

// ===== STATES =====
abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object?> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksError extends BooksState {
  final String message;

  const BooksError(this.message);

  @override
  List<Object?> get props => [message];
}

class CurrentlyReading extends Equatable {
  final BookModel book;
  final ReadingProgressModel progress;

  const CurrentlyReading({
    required this.book,
    required this.progress,
  });

  @override
  List<Object?> get props => [book, progress];
}

class BooksLoaded extends BooksState {
  final CurrentlyReading? currentlyReading;
  final List<CategoryModel> categories;
  final List<BookModel> trendingBooks;
  final List<BookModel> recommendedBooks;
  final List<BookModel> newArrivals;
  final List<BookModel> kidsBooks;
  final List<BookModel> freeBooks;

  const BooksLoaded({
    this.currentlyReading,
    required this.categories,
    required this.trendingBooks,
    required this.recommendedBooks,
    required this.newArrivals,
    required this.kidsBooks,
    required this.freeBooks,
  });

  @override
  List<Object?> get props => [
        currentlyReading,
        categories,
        trendingBooks,
        recommendedBooks,
        newArrivals,
        kidsBooks,
        freeBooks,
      ];
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

// ===== BLOC =====
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getBooksUseCase;
  final SearchBooksUseCase searchBooksUseCase;
  final DownloadBookUseCase downloadBookUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetReadingProgressUseCase getReadingProgressUseCase;

  BooksBloc({
    required this.getBooksUseCase,
    required this.searchBooksUseCase,
    required this.downloadBookUseCase,
    required this.toggleFavoriteUseCase,
    required this.getReadingProgressUseCase,
  }) : super(BooksInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SearchBooks>(_onSearchBooks);
    on<LoadBooksByCategory>(_onLoadBooksByCategory);
    on<DownloadBook>(_onDownloadBook);
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadMoreBooks>(_onLoadMoreBooks);
  }

  // ─────────────────────────────────────────
  // Load Home Data
  // ─────────────────────────────────────────
  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<BooksState> emit,
  ) async {
    emit(BooksLoading());
    try {
      final results = await Future.wait([
        getBooksUseCase.getTrending(),
        getBooksUseCase.getRecommended(),
        getBooksUseCase.getNewArrivals(),
        getBooksUseCase.getFreeBooks(),
        getBooksUseCase.getKidsBooks(),
        getBooksUseCase.getCategories(),
        getReadingProgressUseCase.getCurrentlyReading(),
      ]);

      final trendingBooks = results[0] as List<BookModel>;
      final recommendedBooks = results[1] as List<BookModel>;
      final newArrivals = results[2] as List<BookModel>;
      final freeBooks = results[3] as List<BookModel>;
      final kidsBooks = results[4] as List<BookModel>;
      final categories = results[5] as List<CategoryModel>;
      final currentlyReading = results[6] as CurrentlyReading?;

      emit(BooksLoaded(
        currentlyReading: currentlyReading,
        categories: categories,
        trendingBooks: trendingBooks,
        recommendedBooks: recommendedBooks,
        newArrivals: newArrivals,
        kidsBooks: kidsBooks,
        freeBooks: freeBooks,
      ));
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // Search Books
  // ─────────────────────────────────────────
  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<BooksState> emit,
  ) async {
    emit(BooksLoading());
    try {
      final results = await searchBooksUseCase.execute(
        query: event.query,
        filters: event.filters,
      );

      emit(BookSearchResults(
        results: results.books,
        query: event.query,
        hasMore: results.hasMore,
        totalResults: results.total,
      ));
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // Load Books By Category
  // ─────────────────────────────────────────
  Future<void> _onLoadBooksByCategory(
    LoadBooksByCategory event,
    Emitter<BooksState> emit,
  ) async {
    emit(BooksLoading());
    try {
      final books = await getBooksUseCase.getByCategory(
        event.categoryId,
        page: event.page,
      );

      emit(BookSearchResults(
        results: books.books,
        query: '',
        hasMore: books.hasMore,
        totalResults: books.total,
      ));
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // Download Book
  // ─────────────────────────────────────────
  Future<void> _onDownloadBook(
    DownloadBook event,
    Emitter<BooksState> emit,
  ) async {
    try {
      await for (final progress
          in downloadBookUseCase.execute(event.book)) {
        if (progress < 1.0) {
          emit(BookDownloading(
            bookId: event.book.id,
            progress: progress,
          ));
        } else {
          final localPath =
              await downloadBookUseCase.getLocalPath(event.book.id);
          emit(BookDownloaded(
            bookId: event.book.id,
            localPath: localPath,
          ));
        }
      }
    } catch (e) {
      emit(BooksError('Download failed: ${e.toString()}'));
    }
  }

  // ─────────────────────────────────────────
  // Toggle Favorite
  // ─────────────────────────────────────────
  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<BooksState> emit,
  ) async {
    try {
      await toggleFavoriteUseCase.execute(event.bookId);
      // Reload home data to reflect changes
      add(LoadHomeData());
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // Load More Books (Pagination)
  // ─────────────────────────────────────────
  Future<void> _onLoadMoreBooks(
    LoadMoreBooks event,
    Emitter<BooksState> emit,
  ) async {
    // Only paginate if currently loaded
    if (state is! BooksLoaded) return;
    final currentState = state as BooksLoaded;

    try {
      List<BookModel> newBooks = [];

      switch (event.section) {
        case 'trending':
          newBooks = await getBooksUseCase.getTrending();
          emit(currentState.copyWith(
            trendingBooks: [
              ...currentState.trendingBooks,
              ...newBooks,
            ],
          ));
          break;
        case 'recommended':
          newBooks = await getBooksUseCase.getRecommended();
          emit(currentState.copyWith(
            recommendedBooks: [
              ...currentState.recommendedBooks,
              ...newBooks,
            ],
          ));
          break;
        case 'new':
          newBooks = await getBooksUseCase.getNewArrivals();
          emit(currentState.copyWith(
            newArrivals: [
              ...currentState.newArrivals,
              ...newBooks,
            ],
          ));
          break;
        case 'free':
          newBooks = await getBooksUseCase.getFreeBooks();
          emit(currentState.copyWith(
            freeBooks: [
              ...currentState.freeBooks,
              ...newBooks,
            ],
          ));
          break;
        default:
          debugPrint('Unknown section: ${event.section}');
      }
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }
}

// ─────────────────────────────────────────
// BooksLoaded copyWith extension
// ─────────────────────────────────────────
extension BooksLoadedX on BooksLoaded {
  BooksLoaded copyWith({
    CurrentlyReading? currentlyReading,
    List<CategoryModel>? categories,
    List<BookModel>? trendingBooks,
    List<BookModel>? recommendedBooks,
    List<BookModel>? newArrivals,
    List<BookModel>? kidsBooks,
    List<BookModel>? freeBooks,
  }) {
    return BooksLoaded(
      currentlyReading: currentlyReading ?? this.currentlyReading,
      categories: categories ?? this.categories,
      trendingBooks: trendingBooks ?? this.trendingBooks,
      recommendedBooks: recommendedBooks ?? this.recommendedBooks,
      newArrivals: newArrivals ?? this.newArrivals,
      kidsBooks: kidsBooks ?? this.kidsBooks,
      freeBooks: freeBooks ?? this.freeBooks,
    );
  }
}