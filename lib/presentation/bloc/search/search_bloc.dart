// lib/presentation/blocs/search/search_bloc.dart

import 'package:equatable/equatable.dart';        // Equatable
                                                   // List<Object?> get props

import 'package:flutter_bloc/flutter_bloc.dart';   // Bloc<Event, State>
                                                   // Emitter<State>
                                                   // on<Event>()

// Domain - Models
import '../../../domain/models/book.dart';         // Book

// Domain - Repositories
import '../../../domain/repositories/book_repository.dart';    // BookRepository
                                                               // .searchBooks()

import '../../../domain/repositories/search_repository.dart';  // SearchRepository
                                                               // .getRecentSearches()
                                                               // .getTrendingSearches()
                                                               // .saveRecentSearch()
                                                               // .clearRecentSearches()

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class InitializeSearch extends SearchEvent {}

class SearchBooks extends SearchEvent {
  final String query;
  const SearchBooks({required this.query});

  @override
  List<Object?> get props => [query];
}

class LoadMoreResults extends SearchEvent {}

class ClearSearch extends SearchEvent {}

class SaveRecentSearch extends SearchEvent {
  final String query;
  const SaveRecentSearch({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearRecentSearches extends SearchEvent {}

class ApplyFilters extends SearchEvent {
  final String? category;
  final double? rating;
  final int? year;
  final String sortBy;

  const ApplyFilters({
    this.category,
    this.rating,
    this.year,
    this.sortBy = 'relevance',
  });

  @override
  List<Object?> get props => [
        category,
        rating,
        year,
        sortBy,
      ];
}

class RemoveFilter extends SearchEvent {
  final String filter;
  const RemoveFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class ClearAllFilters extends SearchEvent {}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  final List<String> recentSearches;
  final List<String> trendingSearches;

  const SearchInitial({
    this.recentSearches = const [],
    this.trendingSearches = const [],
  });

  @override
  List<Object?> get props => [
        recentSearches,
        trendingSearches,
      ];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Book> results;
  final int totalResults;
  final bool hasMore;
  final String query;
  final String? selectedCategory;
  final double? selectedRating;
  final int? selectedYear;
  final String sortBy;

  const SearchLoaded({
    required this.results,
    required this.totalResults,
    required this.hasMore,
    required this.query,
    this.selectedCategory,
    this.selectedRating,
    this.selectedYear,
    this.sortBy = 'relevance',
  });

  bool get hasActiveFilters =>
      selectedCategory != null ||
      selectedRating != null ||
      selectedYear != null;

  int get activeFilterCount {
    int count = 0;
    if (selectedCategory != null) count++;
    if (selectedRating != null) count++;
    if (selectedYear != null) count++;
    return count;
  }

  SearchLoaded copyWith({
    List<Book>? results,
    int? totalResults,
    bool? hasMore,
    String? query,
    String? selectedCategory,
    double? selectedRating,
    int? selectedYear,
    String? sortBy,
    bool clearCategory = false,
    bool clearRating = false,
    bool clearYear = false,
  }) {
    return SearchLoaded(
      results: results ?? this.results,
      totalResults:
          totalResults ?? this.totalResults,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ??
              this.selectedCategory),
      selectedRating: clearRating
          ? null
          : (selectedRating ??
              this.selectedRating),
      selectedYear: clearYear
          ? null
          : (selectedYear ?? this.selectedYear),
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object?> get props => [
        results,
        totalResults,
        hasMore,
        query,
        selectedCategory,
        selectedRating,
        selectedYear,
        sortBy,
      ];
}

class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class SearchBloc
    extends Bloc<SearchEvent, SearchState> {
  final BookRepository _bookRepository;
  final SearchRepository _searchRepository;

  int _currentPage = 0;
  static const _pageSize = 20;

  SearchBloc({
    required BookRepository bookRepository,
    required SearchRepository searchRepository,
  })  : _bookRepository = bookRepository,
        _searchRepository = searchRepository,
        super(const SearchInitial()) {
    on<InitializeSearch>(_onInitialize);
    on<SearchBooks>(_onSearch);
    on<LoadMoreResults>(_onLoadMore);
    on<ClearSearch>(_onClearSearch);
    on<SaveRecentSearch>(_onSaveRecent);
    on<ClearRecentSearches>(_onClearRecent);
    on<ApplyFilters>(_onApplyFilters);
    on<RemoveFilter>(_onRemoveFilter);
    on<ClearAllFilters>(_onClearAllFilters);
  }

  // ─────────────────────────────────────────
  // HANDLERS
  // ─────────────────────────────────────────

  Future<void> _onInitialize(
    InitializeSearch event,
    Emitter<SearchState> emit,
  ) async {
    final recent =
        await _searchRepository.getRecentSearches();
    final trending =
        await _searchRepository.getTrendingSearches();
    emit(SearchInitial(
      recentSearches: recent,
      trendingSearches: trending,
    ));
  }

  Future<void> _onSearch(
    SearchBooks event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    _currentPage = 0;

    try {
      final result =
          await _bookRepository.searchBooks(
        query: event.query,
        page: _currentPage,
        pageSize: _pageSize,
      );

      emit(SearchLoaded(
        results: result.books,
        totalResults: result.totalCount,
        hasMore:
            result.books.length >= _pageSize,
        query: event.query,
      ));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreResults event,
    Emitter<SearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SearchLoaded ||
        !currentState.hasMore) return;

    _currentPage++;

    try {
      final result =
          await _bookRepository.searchBooks(
        query: currentState.query,
        page: _currentPage,
        pageSize: _pageSize,
        category: currentState.selectedCategory,
        minRating: currentState.selectedRating,
        year: currentState.selectedYear,
        sortBy: currentState.sortBy,
      );

      final allResults = [
        ...currentState.results,
        ...result.books,
      ];

      emit(currentState.copyWith(
        results: allResults,
        totalResults: result.totalCount,
        hasMore:
            result.books.length >= _pageSize,
      ));
    } catch (e) {
      // Revert page on error
      _currentPage--;
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) async {
    final recent =
        await _searchRepository.getRecentSearches();
    final trending =
        await _searchRepository.getTrendingSearches();
    emit(SearchInitial(
      recentSearches: recent,
      trendingSearches: trending,
    ));
  }

  Future<void> _onSaveRecent(
    SaveRecentSearch event,
    Emitter<SearchState> emit,
  ) async {
    await _searchRepository.saveRecentSearch(
      event.query,
    );
  }

  Future<void> _onClearRecent(
    ClearRecentSearches event,
    Emitter<SearchState> emit,
  ) async {
    await _searchRepository.clearRecentSearches();
    final trending =
        await _searchRepository.getTrendingSearches();
    emit(SearchInitial(
      recentSearches: const [],
      trendingSearches: trending,
    ));
  }

  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<SearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SearchLoaded) return;

    emit(SearchLoading());
    _currentPage = 0;

    try {
      final result =
          await _bookRepository.searchBooks(
        query: currentState.query,
        page: _currentPage,
        pageSize: _pageSize,
        category: event.category,
        minRating: event.rating,
        year: event.year,
        sortBy: event.sortBy,
      );

      emit(SearchLoaded(
        results: result.books,
        totalResults: result.totalCount,
        hasMore:
            result.books.length >= _pageSize,
        query: currentState.query,
        selectedCategory: event.category,
        selectedRating: event.rating,
        selectedYear: event.year,
        sortBy: event.sortBy,
      ));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFilter(
    RemoveFilter event,
    Emitter<SearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SearchLoaded) return;

    SearchLoaded updatedState;
    switch (event.filter) {
      case 'category':
        updatedState = currentState.copyWith(
          clearCategory: true,
        );
        break;
      case 'rating':
        updatedState = currentState.copyWith(
          clearRating: true,
        );
        break;
      case 'year':
        updatedState = currentState.copyWith(
          clearYear: true,
        );
        break;
      default:
        return;
    }

    // Re-search with updated filters
    add(ApplyFilters(
      category: updatedState.selectedCategory,
      rating: updatedState.selectedRating,
      year: updatedState.selectedYear,
      sortBy: updatedState.sortBy,
    ));
  }

  Future<void> _onClearAllFilters(
    ClearAllFilters event,
    Emitter<SearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SearchLoaded) return;

    add(ApplyFilters(sortBy: 'relevance'));
  }
}