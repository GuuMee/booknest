// lib/domain/models/search_filters.dart

import 'package:flutter/material.dart'; // RangeValues

class SearchFilters {
  final String sortBy;
  final RangeValues ratingRange;
  final Set<String> categories;
  final bool freeOnly;

  const SearchFilters({
    required this.sortBy,
    required this.ratingRange,
    required this.categories,
    required this.freeOnly,
  });

  SearchFilters copyWith({
    String? sortBy,
    RangeValues? ratingRange,
    Set<String>? categories,
    bool? freeOnly,
  }) {
    return SearchFilters(
      sortBy: sortBy ?? this.sortBy,
      ratingRange: ratingRange ?? this.ratingRange,
      categories: categories ?? this.categories,
      freeOnly: freeOnly ?? this.freeOnly,
    );
  }
}