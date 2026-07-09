// lib/domain/repositories/book_repository.dart

// Data - Models
import '../../data/models/book_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/bookmark_model.dart';
import '../../data/models/annotation_model.dart';
import '../../data/models/reading_progress_model.dart';
import '../../data/models/collection_model.dart';
import '../../data/models/currently_reading_model.dart';

abstract class BookRepository {
  // Books
  Future<BookModel> getBookById(String id);
  Future<PaginatedBooks> getTrendingBooks({int page = 1});
  Future<PaginatedBooks> getRecommendedBooks({int page = 1});
  Future<PaginatedBooks> getNewArrivals({int page = 1});
  Future<PaginatedBooks> getFreeBooks({int page = 1});
  Future<PaginatedBooks> getKidsBooks({int page = 1});
  Future<PaginatedBooks> getBooksByCategory(String categoryId, {int page = 1});
  Future<SearchResult> searchBooks(String query, {Map<String, dynamic>? filters});
  Future<List<CategoryModel>> getCategories();

  // Reading Progress
  Future<ReadingProgressModel?> getReadingProgress(String bookId);
  Future<void> saveReadingProgress(ReadingProgressModel progress);
  Future<CurrentlyReading?> getCurrentlyReading();

  // Bookmarks
  Future<List<BookmarkModel>> getBookmarks(String bookId);
  Future<void> addBookmark(String bookId, BookmarkModel bookmark);
  Future<void> removeBookmark(String bookmarkId);
  Future<void> updateBookmark(String bookmarkId, BookmarkModel bookmark);

  // Annotations
  Future<List<AnnotationModel>> getAnnotations(String bookId);
  Future<void> addAnnotation(String bookId, AnnotationModel annotation);
  Future<void> removeAnnotation(String annotationId);

  // Favorites & Collections
  Future<void> toggleFavorite(String bookId);
  Future<bool> isFavorite(String bookId);
  Future<List<BookModel>> getFavorites();
  Future<List<CollectionModel>> getCollections();
  Future<void> createCollection(CollectionModel collection);
  Future<void> addToCollection(String collectionId, String bookId);
  Future<void> removeFromCollection(String collectionId, String bookId);

  // Stats
  Future<BookCompletionStats> markBookComplete(String bookId);
  Future<void> rateBook(String bookId, double rating, {String? review});
}

class PaginatedBooks {
  final List<BookModel> books;
  final int total;
  final int page;
  final bool hasMore;

  PaginatedBooks({
    required this.books,
    required this.total,
    required this.page,
    required this.hasMore,
  });
}

class SearchResult {
  final List<BookModel> books;
  final int total;
  final bool hasMore;
  final List<String> suggestions;

  SearchResult({
    required this.books,
    required this.total,
    required this.hasMore,
    this.suggestions = const [],
  });
}

class BookCompletionStats {
  final int totalPages;
  final int totalMinutes;

  BookCompletionStats({
    required this.totalPages,
    required this.totalMinutes,
  });
}