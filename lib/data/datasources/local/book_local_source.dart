// lib/data/datasources/local/book_local_datasource.dart

import 'package:hive/hive.dart';

// Data - Models
import '../../models/book_model.dart';
import '../../models/category_model.dart';
import '../../models/bookmark_model.dart';
import '../../models/annotation_model.dart';
import '../../models/collection_model.dart';
import '../../models/reading_progress_model.dart';
import '../../models/currently_reading_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// EXCEPTION
// ─────────────────────────────────────────────────────────────────────────────

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA SOURCE
// ─────────────────────────────────────────────────────────────────────────────

class BookLocalDataSource {
  final Box<dynamic> _booksBox;
  final Box<dynamic> _progressBox;
  final Box<dynamic> _bookmarksBox;
  final Box<dynamic> _favoritesBox;
  final Box<dynamic> _collectionsBox;
  final Box<dynamic> _annotationsBox;
  final Box<dynamic> _syncQueueBox;
  final Box<dynamic> _cacheBox;

  BookLocalDataSource({
    required Box<dynamic> booksBox,
    required Box<dynamic> progressBox,
    required Box<dynamic> bookmarksBox,
    required Box<dynamic> favoritesBox,
    required Box<dynamic> collectionsBox,
    required Box<dynamic> annotationsBox,
    required Box<dynamic> syncQueueBox,
    required Box<dynamic> cacheBox,
  })  : _booksBox = booksBox,
        _progressBox = progressBox,
        _bookmarksBox = bookmarksBox,
        _favoritesBox = favoritesBox,
        _collectionsBox = collectionsBox,
        _annotationsBox = annotationsBox,
        _syncQueueBox = syncQueueBox,
        _cacheBox = cacheBox;

  // ─────────────────────────────────────────
  // CACHE BOOKS
  // ─────────────────────────────────────────

  Future<void> cacheBook(BookModel book) async {
    await _booksBox.put(book.id, book.toJson());
  }

  Future<BookModel> getCachedBook(String id) async {
    final data = _booksBox.get(id);
    if (data != null) {
      return BookModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    }
    throw const CacheException('Book not found in cache');
  }

  Future<void> cacheTrending(List<BookModel> books) async {
    final ids = books.map((b) => b.id).toList();
    await _cacheBox.put('trending_ids', ids);
    for (final book in books) {
      await cacheBook(book);
    }
  }

  Future<List<BookModel>> getCachedTrending() async {
    final ids =
        _cacheBox.get('trending_ids') as List<dynamic>?;
    if (ids == null) return [];
    return _getBooksFromIds(ids.cast<String>());
  }

  Future<void> cacheRecommended(
      List<BookModel> books) async {
    final ids = books.map((b) => b.id).toList();
    await _cacheBox.put('recommended_ids', ids);
    for (final book in books) {
      await cacheBook(book);
    }
  }

  Future<List<BookModel>> getCachedRecommended() async {
    final ids =
        _cacheBox.get('recommended_ids') as List<dynamic>?;
    if (ids == null) return [];
    return _getBooksFromIds(ids.cast<String>());
  }

  Future<void> cacheCategories(
      List<CategoryModel> categories) async {
    final data =
        categories.map((c) => c.toJson()).toList();
    await _cacheBox.put('categories', data);
  }

  Future<List<CategoryModel>> getCachedCategories() async {
    final data =
        _cacheBox.get('categories') as List<dynamic>?;
    if (data == null) return [];
    return data
        .map(
          (e) => CategoryModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  Future<List<BookModel>> _getBooksFromIds(
      List<String> ids) async {
    final books = <BookModel>[];
    for (final id in ids) {
      try {
        final book = await getCachedBook(id);
        books.add(book);
      } catch (_) {
        continue;
      }
    }
    return books;
  }

  // ─────────────────────────────────────────
  // READING PROGRESS
  // ─────────────────────────────────────────

  Future<ReadingProgressModel?> getProgress(
      String bookId) async {
    final data = _progressBox.get(bookId);
    if (data != null) {
      return ReadingProgressModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    }
    return null;
  }

  Future<void> saveProgress(
      ReadingProgressModel progress) async {
    await _progressBox.put(
      progress.bookId,
      progress.toJson(),
    );
  }

  Future<CurrentlyReading?> getCurrentlyReading() async {
    final allProgress = _progressBox.values
        .map(
          (e) => ReadingProgressModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .where(
          (p) => !p.isCompleted && p.progressPercent > 0,
        )
        .toList()
      ..sort(
        (a, b) => b.lastReadAt.compareTo(a.lastReadAt),
      );

    if (allProgress.isEmpty) return null;

    final latestProgress = allProgress.first;
    try {
      final book =
          await getCachedBook(latestProgress.bookId);
      return CurrentlyReading(
        book: book,
        progress: latestProgress,
      );
    } catch (_) {
      return null;
    }
  }

  // ─────────────────────────────────────────
  // BOOKMARKS
  // ─────────────────────────────────────────

  Future<List<BookmarkModel>> getBookmarks(
      String bookId) async {
    final data =
        _bookmarksBox.get(bookId) as List<dynamic>?;
    if (data == null) return [];
    return data
        .map(
          (e) => BookmarkModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList()
      ..sort(
        (a, b) =>
            a.pageNumber.compareTo(b.pageNumber),
      );
  }

  Future<void> addBookmark(
    String bookId,
    BookmarkModel bookmark,
  ) async {
    final existing = await getBookmarks(bookId);
    existing.add(bookmark);
    await _bookmarksBox.put(
      bookId,
      existing.map((b) => b.toJson()).toList(),
    );
  }

  Future<void> removeBookmark(String bookmarkId) async {
    for (final key in _bookmarksBox.keys) {
      final bookmarks =
          await getBookmarks(key as String);
      final filtered = bookmarks
          .where((b) => b.id != bookmarkId)
          .toList();
      if (filtered.length != bookmarks.length) {
        await _bookmarksBox.put(
          key,
          filtered.map((b) => b.toJson()).toList(),
        );
        break;
      }
    }
  }

  Future<void> updateBookmark(
    String bookmarkId,
    BookmarkModel updated,
  ) async {
    for (final key in _bookmarksBox.keys) {
      final bookmarks =
          await getBookmarks(key as String);
      final index = bookmarks
          .indexWhere((b) => b.id == bookmarkId);
      if (index != -1) {
        bookmarks[index] = updated;
        await _bookmarksBox.put(
          key,
          bookmarks.map((b) => b.toJson()).toList(),
        );
        break;
      }
    }
  }

  // ─────────────────────────────────────────
  // ANNOTATIONS
  // ─────────────────────────────────────────

  Future<List<AnnotationModel>> getAnnotations(
      String bookId) async {
    final data =
        _annotationsBox.get(bookId) as List<dynamic>?;
    if (data == null) return [];
    return data
        .map(
          (e) => AnnotationModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  Future<void> addAnnotation(
    String bookId,
    AnnotationModel annotation,
  ) async {
    final existing = await getAnnotations(bookId);
    existing.add(annotation);
    await _annotationsBox.put(
      bookId,
      existing.map((a) => a.toJson()).toList(),
    );
  }

  Future<void> removeAnnotation(
      String annotationId) async {
    for (final key in _annotationsBox.keys) {
      final annotations =
          await getAnnotations(key as String);
      final filtered = annotations
          .where((a) => a.id != annotationId)
          .toList();
      if (filtered.length != annotations.length) {
        await _annotationsBox.put(
          key,
          filtered.map((a) => a.toJson()).toList(),
        );
        break;
      }
    }
  }

  // ─────────────────────────────────────────
  // FAVORITES
  // ─────────────────────────────────────────

  Future<void> toggleFavorite(String bookId) async {
    final favorites =
        _favoritesBox.get('favorite_ids')
            as List<dynamic>? ??
            [];
    final favoritesList =
        favorites.cast<String>().toList();

    if (favoritesList.contains(bookId)) {
      favoritesList.remove(bookId);
    } else {
      favoritesList.add(bookId);
    }

    await _favoritesBox.put(
      'favorite_ids',
      favoritesList,
    );
  }

  Future<bool> isFavorite(String bookId) async {
    final favorites =
        _favoritesBox.get('favorite_ids')
            as List<dynamic>? ??
            [];
    return favorites.contains(bookId);
  }

  Future<List<BookModel>> getCachedFavorites() async {
    final favorites =
        _favoritesBox.get('favorite_ids')
            as List<dynamic>? ??
            [];
    return _getBooksFromIds(
      favorites.cast<String>(),
    );
  }

  Future<void> cacheFavorites(
      List<BookModel> books) async {
    final ids = books.map((b) => b.id).toList();
    await _favoritesBox.put('favorite_ids', ids);
    for (final book in books) {
      await cacheBook(book);
    }
  }

  // ─────────────────────────────────────────
  // COLLECTIONS
  // ─────────────────────────────────────────

  Future<List<CollectionModel>> getCollections() async {
    final data = _collectionsBox.values.toList();
    return data
        .map(
          (e) => CollectionModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  Future<void> createCollection(
      CollectionModel collection) async {
    await _collectionsBox.put(
      collection.id,
      collection.toJson(),
    );
  }

  Future<void> addToCollection(
    String collectionId,
    String bookId,
  ) async {
    final data = _collectionsBox.get(collectionId);
    if (data != null) {
      final collection = CollectionModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      final updatedBookIds = [
        ...collection.bookIds,
        bookId,
      ];
      final updated = collection.copyWith(
        bookIds: updatedBookIds,
      );
      await _collectionsBox.put(
        collectionId,
        updated.toJson(),
      );
    }
  }

  Future<void> removeFromCollection(
    String collectionId,
    String bookId,
  ) async {
    final data = _collectionsBox.get(collectionId);
    if (data != null) {
      final collection = CollectionModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      final updatedBookIds = collection.bookIds
          .where((id) => id != bookId)
          .toList();
      final updated = collection.copyWith(
        bookIds: updatedBookIds,
      );
      await _collectionsBox.put(
        collectionId,
        updated.toJson(),
      );
    }
  }

  Future<void> deleteCollection(
      String collectionId) async {
    await _collectionsBox.delete(collectionId);
  }

  Future<void> updateCollection(
      CollectionModel collection) async {
    await _collectionsBox.put(
      collection.id,
      collection.toJson(),
    );
  }

  // ─────────────────────────────────────────
  // MARK COMPLETE
  // ─────────────────────────────────────────

  Future<void> markComplete(String bookId) async {
    final progress = await getProgress(bookId);
    if (progress != null) {
      final updated = progress.copyWith(
        isCompleted: true,
        progressPercent: 100.0,
        completedAt: DateTime.now(),
      );
      await saveProgress(updated);
    }
  }

  // ─────────────────────────────────────────
  // SYNC QUEUE
  // ─────────────────────────────────────────

  Future<void> queueForSync(
    String type,
    Map<String, dynamic> data,
  ) async {
    final queueItem = {
      'type': type,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };
    final key =
        '${type}_${DateTime.now().millisecondsSinceEpoch}';
    await _syncQueueBox.put(key, queueItem);
  }

  Future<List<Map<String, dynamic>>>
      getPendingSyncItems() async {
    return _syncQueueBox.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<void> clearSyncItem(String key) async {
    await _syncQueueBox.delete(key);
  }

  Future<void> clearAllSyncItems() async {
    await _syncQueueBox.clear();
  }

  // ─────────────────────────────────────────
  // CACHE MANAGEMENT
  // ─────────────────────────────────────────

  Future<void> clearAllCache() async {
    await _booksBox.clear();
    await _cacheBox.clear();
  }

  Future<int> getCacheSizeBytes() async {
    int total = 0;
    for (final value in _booksBox.values) {
      total += value.toString().length;
    }
    for (final value in _cacheBox.values) {
      total += value.toString().length;
    }
    return total;
  }
}