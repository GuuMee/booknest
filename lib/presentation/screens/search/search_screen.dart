// lib/presentation/screens/search/search_screen.dart

import 'dart:async';                                 // Timer

import 'package:cached_network_image/cached_network_image.dart'; // CachedNetworkImage
import 'package:flutter/material.dart';              // StatefulWidget, Widget,
                                                     // TextEditingController,
                                                     // FocusNode, BuildContext,
                                                     // TextSpan, RichText, etc.
import 'package:flutter_bloc/flutter_bloc.dart';     // BlocBuilder, context.read<>()
import 'package:go_router/go_router.dart';           // context.push()
import 'package:shimmer/shimmer.dart';               // Shimmer.fromColors

// Presentation - BLoC - Search
import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';        // LoadSearchHistory
                                                     // PerformSearch
                                                     // SaveSearchQuery
                                                     // ClearSearchHistory
                                                     // RemoveSearchQuery
import '../../bloc/search/search_state.dart';        // SearchHistoryLoaded
                                                     // SearchLoading
                                                     // SearchResults
                                                     // SearchEmpty
                                                     // SearchError

// Presentation - BLoC - Favorites
import '../../bloc/favorites/favorites_bloc.dart';
import '../../bloc/favorites/favorites_event.dart';  // ToggleFavorite

// Presentation - Widgets - Search
import '../../widgets/search/search_filter_sheet.dart'; // SearchFilterSheet

// Domain - Models
import '../../../domain/models/book_model.dart';     // BookModel

// Core - Theme
import '../../../core/theme/app_colors.dart';        // AppColors

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

  final TextEditingController _searchController =
      TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounceTimer;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    context
        .read<SearchBloc>()
        .add(LoadSearchHistory());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  // ─────────────────────────────────────────
  // SEARCH
  // ─────────────────────────────────────────

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 400),
      () {
        if (query.trim().length >= 2) {
          context.read<SearchBloc>().add(
            PerformSearch(query: query.trim()),
          );
        } else if (query.isEmpty) {
          context
              .read<SearchBloc>()
              .add(LoadSearchHistory());
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
            // ── Search Bar ───────────────
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
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Search Input
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        onChanged: _onSearchChanged,
                        onSubmitted: (query) {
                          if (query
                              .trim()
                              .isNotEmpty) {
                            context
                                .read<SearchBloc>()
                                .add(
                                  PerformSearch(
                                    query:
                                        query.trim(),
                                  ),
                                );
                            context
                                .read<SearchBloc>()
                                .add(
                                  SaveSearchQuery(
                                    query:
                                        query.trim(),
                                  ),
                                );
                          }
                        },
                        decoration: InputDecoration(
                          hintText:
                              'Search books, authors...',
                          hintStyle: TextStyle(
                            color:
                                Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color:
                                Colors.grey.shade400,
                          ),
                          suffixIcon: _searchController
                                  .text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController
                                        .clear();
                                    context
                                        .read<
                                            SearchBloc>()
                                        .add(
                                          LoadSearchHistory(),
                                        );
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors
                                        .grey.shade500,
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Content ──────────────────
            Expanded(
              child: BlocBuilder<SearchBloc,
                  SearchState>(
                builder: (context, state) {
                  if (state
                      is SearchHistoryLoaded) {
                    return _buildSearchHistory(
                      state,
                    );
                  }
                  if (state is SearchLoading) {
                    return _buildSearchLoading();
                  }
                  if (state is SearchResults) {
                    return _buildSearchResults(
                      state,
                    );
                  }
                  if (state is SearchEmpty) {
                    return _buildEmptyResults(
                      state.query,
                    );
                  }
                  if (state is SearchError) {
                    return _buildErrorState(
                      state.message,
                    );
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
  // HISTORY VIEW
  // ─────────────────────────────────────────

  Widget _buildSearchHistory(
    SearchHistoryLoaded state,
  ) {
    return ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      children: [
        // Recent Searches
        if (state.recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<SearchBloc>()
                      .add(ClearSearchHistory());
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...state.recentSearches.map((query) {
            return ListTile(
              onTap: () {
                _searchController.text = query;
                _searchController.selection =
                    TextSelection.fromPosition(
                  TextPosition(
                    offset: query.length,
                  ),
                );
                context.read<SearchBloc>().add(
                  PerformSearch(query: query),
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.history_rounded,
                color: Colors.grey.shade400,
                size: 20,
              ),
              title: Text(query),
              trailing: GestureDetector(
                onTap: () {
                  context.read<SearchBloc>().add(
                    RemoveSearchQuery(query: query),
                  );
                },
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ),
              dense: true,
            );
          }),
          const SizedBox(height: 24),
        ],

        // Trending Searches
        if (state.trendingSearches.isNotEmpty) ...[
          const Text(
            'Trending 🔥',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                state.trendingSearches.map((query) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = query;
                  context.read<SearchBloc>().add(
                    PerformSearch(query: query),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    query,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Browse Categories
        const Text(
          'Browse Categories',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _CategoryChip(
              label: 'Fiction',
              icon: Icons.auto_stories,
              color: Colors.blue,
              onTap: () => context.push(
                '/category/fiction',
              ),
            ),
            _CategoryChip(
              label: 'Science',
              icon: Icons.science,
              color: Colors.green,
              onTap: () => context.push(
                '/category/science',
              ),
            ),
            _CategoryChip(
              label: 'Business',
              icon: Icons.business,
              color: Colors.orange,
              onTap: () => context.push(
                '/category/business',
              ),
            ),
            _CategoryChip(
              label: 'Self-Help',
              icon: Icons.psychology,
              color: Colors.purple,
              onTap: () => context.push(
                '/category/self-help',
              ),
            ),
            _CategoryChip(
              label: 'Technology',
              icon: Icons.computer,
              color: Colors.teal,
              onTap: () => context.push(
                '/category/technology',
              ),
            ),
            _CategoryChip(
              label: 'History',
              icon: Icons.history_edu,
              color: Colors.brown,
              onTap: () => context.push(
                '/category/history',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // LOADING SHIMMER
  // ─────────────────────────────────────────

  Widget _buildSearchLoading() {
    return ListView.builder(
      padding:
          const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 120,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 80,
                        color: Colors.white,
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
  // RESULTS VIEW
  // ─────────────────────────────────────────

  Widget _buildSearchResults(SearchResults state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results Count & Filter Row
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.totalResults} results'
                ' for "${state.query}"',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    _showFilterSheet(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Results List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return _SearchResultTile(
                book: book,
                query: state.query,
                onTap: () => context.push(
                  '/book/${book.id}',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // EMPTY STATE
  // ─────────────────────────────────────────

  Widget _buildEmptyResults(String query) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No results for "$query"',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords or'
              ' check spelling',
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
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_searchController
                  .text.isNotEmpty) {
                context.read<SearchBloc>().add(
                  PerformSearch(
                    query: _searchController.text,
                  ),
                );
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // FILTER SHEET
  // ─────────────────────────────────────────

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) =>
          const SearchFilterSheet(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _SearchResultTile
// ─────────────────────────────────────────────────────────────────────────────

class _SearchResultTile extends StatelessWidget {
  final BookModel book;
  final String query;
  final VoidCallback onTap;

  const _SearchResultTile({
    required this.book,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // Cover
            Hero(
              tag: 'book_cover_${book.id}',
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: book.coverImageUrl,
                  width: 65,
                  height: 90,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      Container(
                    width: 65,
                    height: 90,
                    color: Colors.grey.shade200,
                    child:
                        const Icon(Icons.book),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Title
                  _HighlightedText(
                    text: book.title,
                    highlight: query,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    highlightStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      backgroundColor:
                          Colors.yellow.shade200,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Author
                  _HighlightedText(
                    text: book.author,
                    highlight: query,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                    highlightStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      backgroundColor:
                          Colors.yellow.shade200,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Rating & Category
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        book.rating
                            .toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets
                            .symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(
                            6,
                          ),
                        ),
                        child: Text(
                          book.category,
                          style: TextStyle(
                            color:
                                AppColors.primary,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                      if (book.isPremium) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets
                              .symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .amber.shade50,
                            borderRadius:
                                BorderRadius
                                    .circular(6),
                          ),
                          child: Text(
                            '⭐ PRO',
                            style: TextStyle(
                              color: Colors
                                  .amber.shade800,
                              fontSize: 10,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Favorite Button
            IconButton(
              icon: Icon(
                book.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: book.isFavorite
                    ? Colors.red
                    : Colors.grey.shade400,
                size: 22,
              ),
              onPressed: () {
                context
                    .read<FavoritesBloc>()
                    .add(
                      ToggleFavorite(
                        bookId: book.id,
                      ),
                    );
              },
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
  final String highlight;
  final TextStyle style;
  final TextStyle highlightStyle;

  const _HighlightedText({
    required this.text,
    required this.highlight,
    required this.style,
    required this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerHighlight = highlight.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(
        lowerHighlight,
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
            index + highlight.length,
          ),
          style: highlightStyle,
        ),
      );
      start = index + highlight.length;
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _CategoryChip
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color.withOpacity(0.8),
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}