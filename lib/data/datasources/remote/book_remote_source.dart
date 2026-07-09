// lib/data/datasources/remote/book_remote_datasource.dart

import 'package:dio/dio.dart';

// Domain - Repository (PaginatedBooks, SearchResult, BookCompletionStats)
import '../../../domain/repositories/book_repository.dart';

// Data - Models
import '../../models/book_model.dart';
import '../../models/category_model.dart';
import '../../models/bookmark_model.dart';
import '../../models/annotation_model.dart';
import '../../models/reading_progress_model.dart';
import '../../models/collection_model.dart';

class BookRemoteDataSource {
  final Dio _dio;
  final String _baseUrl;

  BookRemoteDataSource({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  // ===== BOOKS =====

  Future<BookModel> getBook(String id) async {
    final response = await _dio.get('$_baseUrl/books/$id');
    return BookModel.fromJson(response.data['data']);
  }

  Future<PaginatedBooks> getTrending({int page = 1}) async {
    final response = await _dio.get(
      '$_baseUrl/books',
      queryParameters: {
        'sort': 'trending',
        'page': page,
        'limit': 20,
      },
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<PaginatedBooks> getRecommended({int page = 1}) async {
    final response = await _dio.get(
      '$_baseUrl/books/recommended',
      queryParameters: {'page': page, 'limit': 20},
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<PaginatedBooks> getNewArrivals({int page = 1}) async {
    final response = await _dio.get(
      '$_baseUrl/books',
      queryParameters: {
        'sort': 'newest',
        'page': page,
        'limit': 20,
      },
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<PaginatedBooks> getFreeBooks({int page = 1}) async {
    final response = await _dio.get(
      '$_baseUrl/books',
      queryParameters: {
        'filter': 'free',
        'page': page,
        'limit': 20,
      },
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<PaginatedBooks> getKidsBooks({int page = 1}) async {
    final response = await _dio.get(
      '$_baseUrl/books',
      queryParameters: {
        'ageGroup': '3-6,7-12',
        'page': page,
        'limit': 20,
      },
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<PaginatedBooks> getByCategory(
    String categoryId, {
    int page = 1,
  }) async {
    final response = await _dio.get(
      '$_baseUrl/books',
      queryParameters: {
        'category': categoryId,
        'page': page,
        'limit': 20,
      },
    );
    return _parsePaginatedBooks(response.data);
  }

  Future<SearchResult> search(
    String query, {
    Map<String, dynamic>? filters,
  }) async {
    final response = await _dio.get(
      '$_baseUrl/books/search',
      queryParameters: {
        'q': query,
        ...?filters,
      },
    );

    final data = response.data;
    return SearchResult(
      books: (data['data'] as List)
          .map((e) => BookModel.fromJson(e))
          .toList(),
      total: data['pagination']['total'],
      hasMore: data['pagination']['hasMore'],
      suggestions: List<String>.from(data['suggestions'] ?? []),
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('$_baseUrl/categories');
    return (response.data['data'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  // ===== READING PROGRESS =====

  Future<ReadingProgressModel?> getProgress(String bookId) async {
    try {
      final response = await _dio.get('$_baseUrl/progress/$bookId');
      if (response.data['data'] != null) {
        return ReadingProgressModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveProgress(ReadingProgressModel progress) async {
    await _dio.put(
      '$_baseUrl/progress/${progress.bookId}',
      data: progress.toJson(),
    );
  }

  // ===== BOOKMARKS =====

  Future<void> addBookmark(String bookId, BookmarkModel bookmark) async {
    await _dio.post(
      '$_baseUrl/books/$bookId/bookmarks',
      data: bookmark.toJson(),
    );
  }

  Future<void> removeBookmark(String bookmarkId) async {
    await _dio.delete('$_baseUrl/bookmarks/$bookmarkId');
  }

  // ===== FAVORITES =====

  Future<void> toggleFavorite(String bookId) async {
    await _dio.post('$_baseUrl/books/$bookId/favorite');
  }

  Future<List<BookModel>> getFavorites() async {
    final response = await _dio.get('$_baseUrl/favorites');
    return (response.data['data'] as List)
        .map((e) => BookModel.fromJson(e))
        .toList();
  }

  // ===== COLLECTIONS =====

  Future<void> createCollection(CollectionModel collection) async {
    await _dio.post(
      '$_baseUrl/collections',
      data: collection.toJson(),
    );
  }

  Future<void> addToCollection(String collectionId, String bookId) async {
    await _dio.post('$_baseUrl/collections/$collectionId/books/$bookId');
  }

  Future<void> removeFromCollection(
      String collectionId, String bookId) async {
    await _dio.delete('$_baseUrl/collections/$collectionId/books/$bookId');
  }

  // ===== ANNOTATIONS =====

  Future<void> addAnnotation(
      String bookId, AnnotationModel annotation) async {
    await _dio.post(
      '$_baseUrl/books/$bookId/annotations',
      data: annotation.toJson(),
    );
  }

  Future<void> removeAnnotation(String annotationId) async {
    await _dio.delete('$_baseUrl/annotations/$annotationId');
  }

  // ===== RATINGS =====

  Future<void> rateBook(
    String bookId,
    double rating, {
    String? review,
  }) async {
    await _dio.post(
      '$_baseUrl/books/$bookId/rate',
      data: {
        'rating': rating,
        'review': review,
      },
    );
  }

  // ===== MARK COMPLETE =====

  Future<BookCompletionStats> markComplete(String bookId) async {
    final response = await _dio.post('$_baseUrl/books/$bookId/complete');
    return BookCompletionStats(
      totalPages: response.data['totalPages'],
      totalMinutes: response.data['totalMinutes'],
    );
  }

  // ===== HELPERS =====

  PaginatedBooks _parsePaginatedBooks(Map<String, dynamic> data) {
    return PaginatedBooks(
      books: (data['data'] as List)
          .map((e) => BookModel.fromJson(e))
          .toList(),
      total: data['pagination']['total'],
      page: data['pagination']['page'],
      hasMore: data['pagination']['hasMore'],
    );
  }
}