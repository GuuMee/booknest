```dart
// lib/presentation/screens/search/search_screen.dart

import 'dart:async';                               // Timer
                                                   // Timer.cancel()

import 'package:cached_network_image/cached_network_image.dart';
                                                   // CachedNetworkImage

import 'package:flutter/material.dart';            // StatefulWidget
                                                   // StatelessWidget
                                                   // State<T>
                                                   // BuildContext
                                                   // Widget
                                                   // Scaffold
                                                   // SafeArea
                                                   // Column
                                                   // Row
                                                   // Expanded
                                                   // Padding
                                                   // EdgeInsets
                                                   // SizedBox
                                                   // Container
                                                   // BoxDecoration
                                                   // BoxShadow
                                                   // BorderRadius
                                                   // Border
                                                   // BoxShape
                                                   // BoxFit
                                                   // Offset
                                                   // TextEditingController
                                                   // FocusNode
                                                   // TextField
                                                   // InputDecoration
                                                   // InputBorder
                                                   // TextStyle
                                                   // TextSpan
                                                   // RichText
                                                   // TextOverflow
                                                   // TextAlign
                                                   // Text
                                                   // Icon
                                                   // Icons
                                                   // Colors
                                                   // MaterialColor
                                                   // GestureDetector
                                                   // ListView
                                                   // ListView.builder
                                                   // GridView.builder
                                                   // SliverGridDelegateWithFixedCrossAxisCount
                                                   // Wrap
                                                   // Center
                                                   // ClipRRect
                                                   // Spacer
                                                   // CircularProgressIndicator
                                                   // ElevatedButton
                                                   // RoundedRectangleBorder
                                                   // Radius
                                                   // Axis
                                                   // MainAxisAlignment
                                                   // CrossAxisAlignment
                                                   // MainAxisSize
                                                   // BouncingScrollPhysics
                                                   // NeverScrollableScrollPhysics
                                                   // VoidCallback
                                                   // Navigator
                                                   // showModalBottomSheet

import 'package:flutter_bloc/flutter_bloc.dart';   // BlocBuilder<B, S>
                                                   // context.read<T>()

import 'package:go_router/go_router.dart';         // context.push()

import 'package:shimmer/shimmer.dart';             // Shimmer.fromColors

// ── Presentation - BLoC - Search ────────────
import '../../blocs/search/search_bloc.dart';      // SearchBloc

import '../../blocs/search/search_event.dart';     // SearchBooks
                                                   // ClearSearch
                                                   // ClearRecentSearches
                                                   // SaveRecentSearch
                                                   // RemoveFilter
                                                   // ClearAllFilters
                                                   // LoadMoreResults

import '../../blocs/search/search_state.dart';     // SearchState
                                                   // SearchInitial
                                                   // SearchLoading
                                                   // SearchLoaded
                                                   // SearchError

// ── Presentation - Widgets ───────────────────
import '../../widgets/search/search_filter_sheet.dart';
                                                   // _SearchFilterSheet

// ── Domain - Models ──────────────────────────
import '../../../domain/models/book.dart';         // Book
                                                   // Book.id
                                                   // Book.title
                                                   // Book.author
                                                   // Book.coverUrl
                                                   // Book.rating
                                                   // Book.category
                                                   // Book.isFree

// ── Core - Theme ─────────────────────────────
import '../../../core/theme/app_colors.dart';      // AppColors
                                                   // AppColors.primary

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {
  // ─────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────

  final _searchController =
      TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ─────────────────────────────────────────
  // SEARCH
  // ─────────────────────────────────────────

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () {
        if (query.trim().isNotEmpty) {
          context.read<SearchBloc>().add(
            SearchBooks(query: query.trim()),
          );
        } else {
          context
              .read<SearchBloc>()
              .add(ClearSearch());
        }
      },
    );
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ===== SEARCH BAR =====
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                0,
              ),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () =>
                        Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color:
                            Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Search Field
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: TextField(
                        controller:
                            _searchController,
                        focusNode: _focusNode,
                        onChanged:
                            _onSearchChanged,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration:
                            InputDecoration(
                          hintText:
                              'Search books,'
                              ' authors...',
                          hintStyle: TextStyle(
                            color: Colors
                                .grey.shade400,
                            fontSize: 15,
                          ),
                          border:
                              InputBorder.none,
                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors
                                .grey.shade400,
                          ),
                          suffixIcon:
                              _searchController
                                      .text
                                      .isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _searchController
                                            .clear();
                                        context
                                            .read<
                                                SearchBloc>()
                                            .add(
                                              ClearSearch(),
                                            );
                                        setState(
                                          () {},
                                        );
                                      },
                                      child: Icon(
                                        Icons
                                            .close_rounded,
                                        color: Colors
                                            .grey
                                            .shade500,
                                        size: 20,
                                      ),
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== CONTENT =====
            Expanded(
              child: BlocBuilder<SearchBloc,
                  SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return _buildInitialState();
                  }
                  if (state is SearchLoading) {
                    return _buildLoadingState();
                  }
                  if (state is SearchError) {
                    return _buildErrorState(
                      state.message,
                    );
                  }
                  if (state is SearchLoaded) {
                    if (state.results.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildResults(state);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // INITIAL STATE
  // ─────────────────────────────────────────

  Widget _buildInitialState() {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        // Recent Searches
        BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (prev, curr) =>
              curr is SearchInitial,
          builder: (context, state) {
            final recentSearches =
                state is SearchInitial
                    ? state.recentSearches
                    : <String>[];

            if (recentSearches.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    const Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<SearchBloc>()
                            .add(
                              ClearRecentSearches(),
                            );
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          color:
                              AppColors.primary,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: recentSearches
                      .map((search) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text =
                            search;
                        _onSearchChanged(search);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets
                            .symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration:
                            BoxDecoration(
                          color: Colors
                              .grey.shade100,
                          borderRadius:
                              BorderRadius
                                  .circular(20),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .history_rounded,
                              size: 16,
                              color: Colors
                                  .grey.shade500,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              search,
                              style: TextStyle(
                                color: Colors.grey
                                    .shade700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
              ],
            );
          },
        ),

        // Trending Searches
        const Text(
          'Trending 🔥',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            final trending =
                state is SearchInitial
                    ? state.trendingSearches
                    : <String>[];

            return Column(
              children: trending.asMap().entries
                  .map((entry) {
                final index = entry.key;
                final term = entry.value;
                return _TrendingItem(
                  rank: index + 1,
                  term: term,
                  onTap: () {
                    _searchController.text =
                        term;
                    _onSearchChanged(term);
                    setState(() {});
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 28),

        // Popular Categories
        const Text(
          'Browse Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _buildCategoryGrid(),
      ],
    );
  }

  // ─────────────────────────────────────────
  // CATEGORY GRID
  // ─────────────────────────────────────────

  Widget _buildCategoryGrid() {
    final categories = [
      _CategoryItem(
        '📚',
        'Fiction',
        Colors.blue,
      ),
      _CategoryItem(
        '🔬',
        'Science',
        Colors.green,
      ),
      _CategoryItem(
        '💼',
        'Business',
        Colors.orange,
      ),
      _CategoryItem('🎨', 'Art', Colors.pink),
      _CategoryItem(
        '🧠',
        'Psychology',
        Colors.purple,
      ),
      _CategoryItem(
        '📖',
        'Biography',
        Colors.teal,
      ),
      _CategoryItem(
        '🌍',
        'Travel',
        Colors.cyan,
      ),
      _CategoryItem(
        '💻',
        'Technology',
        Colors.indigo,
      ),
      _CategoryItem(
        '❤️',
        'Romance',
        Colors.red,
      ),
      _CategoryItem(
        '🔮',
        'Fantasy',
        Colors.deepPurple,
      ),
      _CategoryItem(
        '🕵️',
        'Mystery',
        Colors.brown,
      ),
      _CategoryItem(
        '📝',
        'Self-Help',
        Colors.amber,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.3,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return GestureDetector(
          onTap: () {
            context.push(
              '/category/'
              '${cat.name.toLowerCase()}',
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: cat.color.withOpacity(0.08),
              borderRadius:
                  BorderRadius.circular(16),
              border: Border.all(
                color:
                    cat.color.withOpacity(0.15),
              ),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  cat.emoji,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  cat.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: cat.color.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // LOADING STATE
  // ─────────────────────────────────────────

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // EMPTY STATE
  // ─────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Results Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different'
              ' keywords or browse our categories.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // ERROR STATE
  // ─────────────────────────────────────────

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _onSearchChanged(
                  _searchController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // SEARCH RESULTS
  // ─────────────────────────────────────────

  Widget _buildResults(SearchLoaded state) {
    return Column(
      children: [
        // Results header with filters
        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            8,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.totalResults} results',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    _showFilterBottomSheet(
                  context,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: state.hasActiveFilters
                        ? AppColors.primary
                            .withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          state.hasActiveFilters
                              ? AppColors.primary
                              : Colors
                                  .grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 16,
                        color:
                            state.hasActiveFilters
                                ? AppColors.primary
                                : Colors
                                    .grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600,
                          color:
                              state.hasActiveFilters
                                  ? AppColors
                                      .primary
                                  : Colors.grey
                                      .shade600,
                        ),
                      ),
                      if (state
                          .hasActiveFilters) ...[
                        const SizedBox(width: 4),
                        Container(
                          width: 18,
                          height: 18,
                          decoration:
                              BoxDecoration(
                            color:
                                AppColors.primary,
                            shape:
                                BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${state.activeFilterCount}',
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 10,
                                fontWeight:
                                    FontWeight
                                        .w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Filter chips (active)
        if (state.hasActiveFilters)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              children: [
                if (state.selectedCategory !=
                    null)
                  _FilterChip(
                    label:
                        state.selectedCategory!,
                    onRemove: () {
                      context
                          .read<SearchBloc>()
                          .add(
                            RemoveFilter(
                              filter: 'category',
                            ),
                          );
                    },
                  ),
                if (state.selectedRating != null)
                  _FilterChip(
                    label:
                        '${state.selectedRating}'
                        '+ ⭐',
                    onRemove: () {
                      context
                          .read<SearchBloc>()
                          .add(
                            RemoveFilter(
                              filter: 'rating',
                            ),
                          );
                    },
                  ),
                if (state.selectedYear != null)
                  _FilterChip(
                    label: '${state.selectedYear}',
                    onRemove: () {
                      context
                          .read<SearchBloc>()
                          .add(
                            RemoveFilter(
                              filter: 'year',
                            ),
                          );
                    },
                  ),
                _FilterChip(
                  label: 'Clear All',
                  isReset: true,
                  onRemove: () {
                    context
                        .read<SearchBloc>()
                        .add(ClearAllFilters());
                  },
                ),
              ],
            ),
          ),

        // Results list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              100,
            ),
            physics:
                const BouncingScrollPhysics(),
            itemCount: state.results.length +
                (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index ==
                  state.results.length) {
                context
                    .read<SearchBloc>()
                    .add(LoadMoreResults());
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }

              final book =
                  state.results[index];
              return _SearchResultItem(
                book: book,
                searchQuery:
                    _searchController.text,
                onTap: () {
                  context
                      .read<SearchBloc>()
                      .add(
                        SaveRecentSearch(
                          query:
                              _searchController
                                  .text,
                        ),
                      );
                  context.push(
                    '/book/${book.id}',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // FILTER BOTTOM SHEET
  // ─────────────────────────────────────────

  void _showFilterBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) =>
          const _SearchFilterSheet(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE MODEL — _CategoryItem
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryItem {
  final String emoji;
  final String name;
  final MaterialColor color;

  _CategoryItem(this.emoji, this.name, this.color);
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _TrendingItem
// ─────────────────────────────────────────────────────────────────────────────

class _TrendingItem extends StatelessWidget {
  final int rank;
  final String term;
  final VoidCallback onTap;

  const _TrendingItem({
    required this.rank,
    required this.term,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '$rank',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: rank <= 3
                      ? AppColors.primary
                      : Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (rank <= 3)
              Icon(
                Icons.trending_up_rounded,
                size: 18,
                color: Colors.red.shade400,
              ),
            if (rank <= 3)
              const SizedBox(width: 8),
            Text(
              term,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.north_west_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _FilterChip
// ─────────────────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  final bool isReset;

  const _FilterChip({
    required this.label,
    required this.onRemove,
    this.isReset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
        onTap: onRemove,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isReset
                ? Colors.grey.shade100
                : AppColors.primary
                    .withOpacity(0.1),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isReset
                      ? Colors.grey.shade600
                      : AppColors.primary,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.close_rounded,
                size: 14,
                color: isReset
                    ? Colors.grey.shade600
                    : AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _SearchResultItem
// ─────────────────────────────────────────────────────────────────────────────

class _SearchResultItem extends StatelessWidget {
  final Book book;
  final String searchQuery;
  final VoidCallback onTap;

  const _SearchResultItem({
    required this.book,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 14,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Cover
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: book.coverUrl,
                width: 60,
                height: 85,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.book_rounded,
                    color:
                        Colors.grey.shade400,
                  ),
                ),
                errorWidget: (_, __, ___) =>
                    Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.broken_image_rounded,
                    color:
                        Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Title with highlight
                  _HighlightedText(
                    text: book.title,
                    query: searchQuery,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w700,
                      fontSize: 15,
                    ),
                    highlightStyle: TextStyle(
                      fontWeight:
                          FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.primary,
                      backgroundColor:
                          AppColors.primary
                              .withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Author
                  _HighlightedText(
                    text: book.author,
                    query: searchQuery,
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontSize: 13,
                    ),
                    highlightStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                      backgroundColor:
                          AppColors.primary
                              .withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Rating + Category
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors
                            .amber.shade600,
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        book.rating
                            .toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration:
                            BoxDecoration(
                          color: Colors
                              .grey.shade100,
                          borderRadius:
                              BorderRadius
                                  .circular(6),
                        ),
                        child: Text(
                          book.category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w600,
                            color: Colors
                                .grey.shade600,
                          ),
                        ),
                      ),
                      if (book.isFree) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .green.shade50,
                            borderRadius:
                                BorderRadius
                                    .circular(6),
                          ),
                          child: Text(
                            'FREE',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight
                                      .w800,
                              color: Colors
                                  .green.shade700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _HighlightedText
// ─────────────────────────────────────────────────────────────────────────────

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle style;
  final TextStyle highlightStyle;

  const _HighlightedText({
    required this.text,
    required this.query,
    required this.style,
    required this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(
        lowerQuery,
        start,
      );
      if (index == -1) {
        spans.add(
          TextSpan(
            text: text.substring(start),
            style: style,
          ),
        );
        break;
      }
      if (index > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, index),
            style: style,
          ),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(
            index,
            index + query.length,
          ),
          style: highlightStyle,
        ),
      );
      start = index + query.length;
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}