// lib/domain/models/search_result.dart

import 'book_model.dart';

class SearchResult {
  final List<BookModel> books;
  final int totalCount;

  const SearchResult({
    required this.books,
    required this.totalCount,
  });
}