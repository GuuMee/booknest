// lib/data/repositories/book_repository_impl.dart

import 'package:flutter/foundation.dart'; // debugPrint

// Domain - Repository Interface
import '../../domain/repositories/book_repository.dart';

// Data - Models
import '../../data/models/book_model.dart'; // ✅ Fixed: removed double ;;
import '../../data/models/category_model.dart';
import '../../data/models/bookmark_model.dart';
import '../../data/models/annotation_model.dart';
import '../../data/models/reading_progress_model.dart';
import '../../data/models/collection_model.dart';
import '../../data/models/currently_reading_model.dart';

// Data - Data Sources
import '../../data/datasources/remote/book_remote_source.dart';
import '../../data/datasources/local/book_local_source.dart';

// Core - Network
import '../../core/network/network_info.dart';

// ─────────────────────────────────────────────────────────────────────────────

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // ── Get Book By ID ──────────────────────────────────────────────────────────
  @override
  Future<BookModel> getBookById(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final book = await remoteDataSource.getBook(id);
        await localDataSource.cacheBook(book);
        return book;
      } else {
        return await localDataSource.getCachedBook(id);
      }
    } catch (e) {
      try {
        return await localDataSource.getCachedBook(id);
      } catch (_) {
        throw ServerException('Failed to load book');
      }
    }
  }

  // ── Trending Books ──────────────────────────────────────────────────────────
  @override
  Future<PaginatedBooks> getTrendingBooks({int page = 1}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getTrending(page: page);
        if (page == 1) {
          await localDataSource.cacheTrending(result.books);
        }
        return result;
      } else {
        final cached = await localDataSource.getCachedTrending();
        return PaginatedBooks(
          books: cached,
          total: cached.length,
          page: 1,
          hasMore: false,
        );
      }
    } catch (e) {
      final cached = await localDataSource.getCachedTrending();
      if (cached.isNotEmpty) {
        return PaginatedBooks(
          books: cached,
          total: cached.length,
          page: 1,
          hasMore: false,
        );
      }
      throw ServerException('Failed to load trending books');
    }
  }

  // ── Recommended Books ───────────────────────────────────────────────────────
  @override
  Future<PaginatedBooks> getRecommendedBooks({int page = 1}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getRecommended(page: page);
        if (page == 1) {
          await localDataSource.cacheRecommended(result.books);
        }
        return result;
      } else {
        final cached = await localDataSource.getCachedRecommended();
        return PaginatedBooks(
          books: cached,
          total: cached.length,
          page: 1,
          hasMore: false,
        );
      }
    } catch (e) {
      throw ServerException('Failed to load recommended books');
    }
  }

  // ── New Arrivals ────────────────────────────────────────────────────────────
  @override
  Future<PaginatedBooks> getNewArrivals({int page = 1}) async {
    try {
      return await remoteDataSource.getNewArrivals(page: page);
    } catch (e) {
      throw ServerException('Failed to load new arrivals');
    }
  }

  // ── Free Books ──────────────────────────────────────────────────────────────
  @override
  Future<PaginatedBooks> getFreeBooks({int page = 1}) async {
    try {
      return await remoteDataSource.getFreeBooks(page: page);
    } catch (e) {
      throw ServerException('Failed to load free books');
    }
  }

  // ── Kids Books ──────────────────────────────────────────────────────────────
  @override
  Future<PaginatedBooks> getKidsBooks({int page = 1}) async {
    try {
      return await remoteDataSource.getKidsBooks(page: page);
    } catch (e) {
      throw ServerException('Failed to load kids books');
    }
  }

  // ── Search Books ────────────────────────────────────────────────────────────
  @override
  Future<SearchResult> searchBooks(
    String query, {
    Map<String, dynamic>? filters,
  }) async {
    try {
      return await remoteDataSource.search(query, filters: filters);
    } catch (e) {
      throw ServerException('Search failed');
    }
  }

  // ── Reading Progress ────────────────────────────────────────────────────────
  @override
  Future<ReadingProgressModel?> getReadingProgress(String bookId) async {
    try {
      final localProgress = await localDataSource.getProgress(bookId);
      if (localProgress != null) return localProgress;

      if (await networkInfo.isConnected) {
        final remoteProgress = await remoteDataSource.getProgress(bookId);
        if (remoteProgress != null) {
          await localDataSource.saveProgress(remoteProgress);
        }
        return remoteProgress;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveReadingProgress(ReadingProgressModel progress) async {
    try {
      await localDataSource.saveProgress(progress);
      if (await networkInfo.isConnected) {
        await remoteDataSource.saveProgress(progress);
      } else {
        await localDataSource.queueForSync('progress', progress.toJson());
      }
    } catch (e) {
      debugPrint('Failed to save progress: $e');
    }
  }

  // ── Bookmarks ───────────────────────────────────────────────────────────────
  @override
  Future<void> addBookmark(String bookId, BookmarkModel bookmark) async {
    try {
      await localDataSource.addBookmark(bookId, bookmark);
      if (await networkInfo.isConnected) {
        await remoteDataSource.addBookmark(bookId, bookmark);
      }
    } catch (e) {
      throw ServerException('Failed to add bookmark');
    }
  }

  // ✅ FIX #2 — Added missing updateBookmark method
  @override
  Future<void> updateBookmark(BookmarkModel bookmark) async {
    try {
      await localDataSource.updateBookmark(bookmark);
      if (await networkInfo.isConnected) {
        await remoteDataSource.updateBookmark(bookmark);
      }
    } catch (e) {
      throw ServerException('Failed to update bookmark');
    }
  }

  @override
  Future<void> removeBookmark(String bookmarkId) async {
    try {
      await localDataSource.removeBookmark(bookmarkId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.removeBookmark(bookmarkId);
      }
    } catch (e) {
      throw ServerException('Failed to remove bookmark');
    }
  }

  @override
  Future<List<BookmarkModel>> getBookmarks(String bookId) async {
    try {
      return await localDataSource.getBookmarks(bookId);
    } catch (e) {
      return [];
    }
  }

  // ── Favorites ───────────────────────────────────────────────────────────────
  @override
  Future<void> toggleFavorite(String bookId) async {
    try {
      await localDataSource.toggleFavorite(bookId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.toggleFavorite(bookId);
      }
    } catch (e) {
      throw ServerException('Failed to toggle favorite');
    }
  }

  @override
  Future<bool> isFavorite(String bookId) async {
    return await localDataSource.isFavorite(bookId);
  }

  @override
  Future<List<BookModel>> getFavorites() async {
    try {
      if (await networkInfo.isConnected) {
        final favorites = await remoteDataSource.getFavorites();
        await localDataSource.cacheFavorites(favorites);
        return favorites;
      }
      return await localDataSource.getCachedFavorites();
    } catch (e) {
      return await localDataSource.getCachedFavorites();
    }
  }

  // ── Categories ──────────────────────────────────────────────────────────────
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        final categories = await remoteDataSource.getCategories();
        await localDataSource.cacheCategories(categories);
        return categories;
      }
      return await localDataSource.getCachedCategories();
    } catch (e) {
      return await localDataSource.getCachedCategories();
    }
  }

  @override
  Future<PaginatedBooks> getBooksByCategory(
    String categoryId, {
    int page = 1,
  }) async {
    try {
      return await remoteDataSource.getByCategory(categoryId, page: page);
    } catch (e) {
      throw ServerException('Failed to load category');
    }
  }

  // ── Mark Complete ───────────────────────────────────────────────────────────
  @override
  Future<BookCompletionStats> markBookComplete(String bookId) async {
    try {
      await localDataSource.markComplete(bookId);
      if (await networkInfo.isConnected) {
        return await remoteDataSource.markComplete(bookId);
      }
      return BookCompletionStats(totalPages: 0, totalMinutes: 0);
    } catch (e) {
      throw ServerException('Failed to mark complete');
    }
  }

  // ── Rate Book ───────────────────────────────────────────────────────────────
  @override
  Future<void> rateBook(
    String bookId,
    double rating, {
    String? review,
  }) async {
    try {
      await remoteDataSource.rateBook(bookId, rating, review: review);
    } catch (e) {
      throw ServerException('Failed to submit rating');
    }
  }

  // ── Currently Reading ───────────────────────────────────────────────────────
  // ✅ FIX #1 — Changed CurrentlyReading → CurrentlyReadingModel
  @override
  Future<CurrentlyReadingModel?> getCurrentlyReading() async {
    try {
      return await localDataSource.getCurrentlyReading();
    } catch (e) {
      return null;
    }
  }

  // ── Collections ─────────────────────────────────────────────────────────────
  @override
  Future<List<CollectionModel>> getCollections() async {
    try {
      return await localDataSource.getCollections();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> createCollection(CollectionModel collection) async {
    await localDataSource.createCollection(collection);
    if (await networkInfo.isConnected) {
      await remoteDataSource.createCollection(collection);
    }
  }

  @override
  Future<void> addToCollection(String collectionId, String bookId) async {
    await localDataSource.addToCollection(collectionId, bookId);
    if (await networkInfo.isConnected) {
      await remoteDataSource.addToCollection(collectionId, bookId);
    }
  }

  @override
  Future<void> removeFromCollection(
    String collectionId,
    String bookId,
  ) async {
    await localDataSource.removeFromCollection(collectionId, bookId);
    if (await networkInfo.isConnected) {
      await remoteDataSource.removeFromCollection(collectionId, bookId);
    }
  }

  // ── Annotations ─────────────────────────────────────────────────────────────
  @override
  Future<List<AnnotationModel>> getAnnotations(String bookId) async {
    return await localDataSource.getAnnotations(bookId);
  }

  @override
  Future<void> addAnnotation(
    String bookId,
    AnnotationModel annotation,
  ) async {
    await localDataSource.addAnnotation(bookId, annotation);
    if (await networkInfo.isConnected) {
      await remoteDataSource.addAnnotation(bookId, annotation);
    }
  }

  @override
  Future<void> removeAnnotation(String annotationId) async {
    await localDataSource.removeAnnotation(annotationId);
    if (await networkInfo.isConnected) {
      await remoteDataSource.removeAnnotation(annotationId);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Server Exception
// ─────────────────────────────────────────────────────────────────────────────

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}