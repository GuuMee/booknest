// lib/domain/repositories/search_repository.dart

import '../models/book_model.dart';
import '../models/search_result.dart';
import '../../presentation/blocs/search/search_bloc.dart'; // SearchFilters

abstract class SearchRepository {
  Future<SearchResult> search({
    required String query,
    SearchFilters? filters,
  });

  Future<List<String>> getTrendingSearches();
}