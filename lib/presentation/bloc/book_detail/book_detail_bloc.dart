// lib/presentation/bloc/book_detail/book_detail_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Data - Models
import '../../../data/models/book_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/reading_progress_model.dart';

// Data - Repositories
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/subscription_repository.dart';

// Data - Services
import '../../../data/services/download_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookDetail extends BookDetailEvent {
  final String bookId;

  const LoadBookDetail({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class ToggleBookFavorite extends BookDetailEvent {
  final String bookId;

  const ToggleBookFavorite({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class RateBook extends BookDetailEvent {
  final String bookId;
  final double rating;
  final String? review;

  const RateBook({
    required this.bookId,
    required this.rating,
    this.review,
  });

  @override
  List<Object?> get props => [bookId, rating, review];
}

class DeleteBookDownload extends BookDetailEvent {
  final String bookId;

  const DeleteBookDownload({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object?> get props => [];
}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final BookModel book;
  final bool isFavorite;
  final bool isDownloaded;
  final bool hasSubscription;
  final ReadingProgressModel? readingProgress;
  final List<ReviewModel> reviews;
  final List<BookModel> similarBooks;

  const BookDetailLoaded({
    required this.book,
    required this.isFavorite,
    required this.isDownloaded,
    required this.hasSubscription,
    this.readingProgress,
    required this.reviews,
    required this.similarBooks,
  });

  BookDetailLoaded copyWith({
    BookModel? book,
    bool? isFavorite,
    bool? isDownloaded,
    bool? hasSubscription,
    ReadingProgressModel? readingProgress,
    List<ReviewModel>? reviews,
    List<BookModel>? similarBooks,
  }) {
    return BookDetailLoaded(
      book: book ?? this.book,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      readingProgress: readingProgress ?? this.readingProgress,
      reviews: reviews ?? this.reviews,
      similarBooks: similarBooks ?? this.similarBooks,
    );
  }

  @override
  List<Object?> get props => [
        book,
        isFavorite,
        isDownloaded,
        hasSubscription,
        readingProgress,
        reviews,
        similarBooks,
      ];
}

class BookDetailError extends BookDetailState {
  final String message;

  const BookDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final BookRepository bookRepository;
  final SubscriptionRepository subscriptionRepository;
  final DownloadService downloadService;

  BookDetailBloc({
    required this.bookRepository,
    required this.subscriptionRepository,
    required this.downloadService,
  }) : super(BookDetailInitial()) {
    on<LoadBookDetail>(_onLoadDetail);
    on<ToggleBookFavorite>(_onToggleFavorite);
    on<RateBook>(_onRateBook);
    on<DeleteBookDownload>(_onDeleteDownload);
  }

  // ─────────────────────────────────────────
  // HANDLERS
  // ─────────────────────────────────────────

  Future<void> _onLoadDetail(
    LoadBookDetail event,
    Emitter<BookDetailState> emit,
  ) async {
    emit(BookDetailLoading());
    try {
      final results = await Future.wait([
        bookRepository.getBookById(event.bookId),
        bookRepository.isFavorite(event.bookId),
        downloadService.isDownloaded(event.bookId),
        subscriptionRepository.hasActiveSubscription(),
        bookRepository.getReadingProgress(event.bookId),
      ]);

      final book           = results[0] as BookModel;
      final isFavorite     = results[1] as bool;
      final isDownloaded   = results[2] as bool;
      final hasSubscription = results[3] as bool;
      final progress       = results[4] as ReadingProgressModel?;

      // Load reviews and similar books (non-blocking)
      List<ReviewModel> reviews     = [];
      List<BookModel>   similarBooks = [];

      try {
        final extraResults = await Future.wait([
          _loadReviews(event.bookId),
          _loadSimilarBooks(book),
        ]);
        reviews      = extraResults[0] as List<ReviewModel>;
        similarBooks = extraResults[1] as List<BookModel>;
      } catch (_) {
        // Non-critical — continue with empty lists
      }

      emit(BookDetailLoaded(
        book: book,
        isFavorite: isFavorite,
        isDownloaded: isDownloaded,
        hasSubscription: hasSubscription,
        readingProgress: progress,
        reviews: reviews,
        similarBooks: similarBooks,
      ));
    } catch (e) {
      emit(BookDetailError(message: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleBookFavorite event,
    Emitter<BookDetailState> emit,
  ) async {
    if (state is! BookDetailLoaded) return;

    final current = state as BookDetailLoaded;

    // Optimistic update
    emit(current.copyWith(isFavorite: !current.isFavorite));

    try {
      await bookRepository.toggleFavorite(event.bookId);
    } catch (_) {
      // Revert on failure
      emit(current.copyWith(isFavorite: current.isFavorite));
    }
  }

  Future<void> _onRateBook(
    RateBook event,
    Emitter<BookDetailState> emit,
  ) async {
    try {
      await bookRepository.rateBook(
        event.bookId,
        event.rating,
        review: event.review,
      );
      // Reload to get updated rating
      add(LoadBookDetail(bookId: event.bookId));
    } catch (_) {
      // TODO: emit error snackbar event
    }
  }

  Future<void> _onDeleteDownload(
    DeleteBookDownload event,
    Emitter<BookDetailState> emit,
  ) async {
    try {
      await downloadService.deleteDownload(event.bookId);
      if (state is BookDetailLoaded) {
        emit((state as BookDetailLoaded).copyWith(isDownloaded: false));
      }
    } catch (_) {
      // TODO: handle error
    }
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  Future<List<ReviewModel>> _loadReviews(String bookId) async {
    // TODO: Implement review loading from repository
    return [];
  }

  Future<List<BookModel>> _loadSimilarBooks(BookModel book) async {
    if (book.categories.isEmpty) return [];
    final result = await bookRepository.getBooksByCategory(
      book.categories.first,
    );
    return result.books
        .where((b) => b.id != book.id)
        .take(10)
        .toList();
  }
}