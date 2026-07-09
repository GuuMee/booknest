// lib/presentation/screens/explore/explore_screen.dart

import 'dart:async';                          // Timer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';    // context.push
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';

// Data - Models
import '../../../data/models/book_model.dart';
import '../../../data/models/category_model.dart';

// Presentation - BLoC
import '../../blocs/explore/explore_bloc.dart';
import '../../blocs/explore/explore_event.dart';
import '../../blocs/explore/explore_state.dart';

// Core - Theme
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController _tabController;
  Timer? _debounce;

  String _selectedSort = 'popular';
  String? _selectedCategory;
  String? _selectedLanguage;
  String? _selectedAgeGroup;
  bool _showFilters = false;

  final List<String> _sortOptions = [
    'popular',
    'newest',
    'rating',
    'title_asc',
    'title_desc',
  ];

  final Map<String, String> _sortLabels = {
    'popular': '🔥 Popular',
    'newest': '🆕 Newest',
    'rating': '⭐ Top Rated',
    'title_asc': 'A → Z',
    'title_desc': 'Z → A',
  };

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<ExploreBloc>().add(LoadExploreData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        context.read<ExploreBloc>().add(
              SearchExplore(
                query: query.trim(),
                filters: _buildFilters(),
              ),
            );
      } else {
        context.read<ExploreBloc>().add(LoadExploreData());
      }
    });
  }

  Map<String, dynamic> _buildFilters() {
    return {
      'sort': _selectedSort,
      if (_selectedCategory != null) 'category': _selectedCategory,
      if (_selectedLanguage != null) 'language': _selectedLanguage,
      if (_selectedAgeGroup != null) 'ageGroup': _selectedAgeGroup,
    };
  }

  bool _hasActiveFilters() {
    return _selectedCategory != null ||
        _selectedLanguage != null ||
        _selectedAgeGroup != null;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedLanguage = null;
      _selectedAgeGroup = null;
      _selectedSort = 'popular';
    });
    _applyFilters();
  }

  void _applyFilters() {
    context.read<ExploreBloc>().add(
          ApplyFilters(filters: _buildFilters()),
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
            // ===== SEARCH HEADER =====
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore', style: AppTypography.heading1),
                  const SizedBox(height: 4),
                  Text(
                    'Discover your next favorite book',
                    style: AppTypography.bodyMedium
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search books, authors, ISBN...',
                        hintStyle:
                            TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade500,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_searchController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                              ),
                            IconButton(
                              icon: Icon(
                                _showFilters
                                    ? Icons.tune_rounded
                                    : Icons.tune_outlined,
                                color: _showFilters
                                    ? AppColors.primary
                                    : Colors.grey.shade500,
                              ),
                              onPressed: () => setState(
                                () =>
                                    _showFilters = !_showFilters,
                              ),
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== FILTERS =====
            AnimatedCrossFade(
              firstChild:
                  const SizedBox(width: double.infinity),
              secondChild: _buildFiltersSection(),
              crossFadeState: _showFilters
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            // ===== TABS =====
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              tabAlignment: TabAlignment.start,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              tabs: const [
                Tab(text: '📚 All'),
                Tab(text: '🆓 Free'),
                Tab(text: '⭐ Premium'),
                Tab(text: '🧒 Kids'),
              ],
              onTap: (index) {
                final filters = {
                  0: null,
                  1: 'free',
                  2: 'premium',
                  3: 'kids',
                };
                context.read<ExploreBloc>().add(
                      FilterExplore(filter: filters[index]),
                    );
              },
            ),

            // ===== SORT BAR =====
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Row(
                children: [
                  BlocBuilder<ExploreBloc, ExploreState>(
                    builder: (context, state) {
                      final total = state is ExploreLoaded
                          ? state.totalResults
                          : 0;
                      return Text(
                        '$total books found',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    initialValue: _selectedSort,
                    onSelected: (value) {
                      setState(() => _selectedSort = value);
                      context.read<ExploreBloc>().add(
                            SortExplore(sortBy: value),
                          );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _sortLabels[_selectedSort]!,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    itemBuilder: (context) =>
                        _sortOptions.map((option) {
                      return PopupMenuItem(
                        value: option,
                        child: Text(_sortLabels[option]!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // ===== BOOK GRID =====
            Expanded(
              child: BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoading) {
                    return _buildGridShimmer();
                  }
                  if (state is ExploreError) {
                    return _buildGridError(state.message);
                  }
                  if (state is ExploreLoaded) {
                    if (state.books.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildBookGrid(state);
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
  // FILTERS SECTION
  // ─────────────────────────────────────────

  Widget _buildFiltersSection() {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        final categories = state is ExploreLoaded
            ? state.categories
            : <CategoryModel>[];
        final languages = state is ExploreLoaded
            ? state.languages
            : <String>[];

        return Container(
          padding:
              const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Categories ──
              Text(
                'Category',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _selectedCategory == null,
                      onTap: () {
                        setState(
                          () => _selectedCategory = null,
                        );
                        _applyFilters();
                      },
                    ),
                    ...categories.map(
                      (cat) => _FilterChip(
                        label: cat.name,
                        isSelected:
                            _selectedCategory == cat.id,
                        onTap: () {
                          setState(
                            () =>
                                _selectedCategory = cat.id,
                          );
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Language ──
              Text(
                'Language',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _selectedLanguage == null,
                      onTap: () {
                        setState(
                          () => _selectedLanguage = null,
                        );
                        _applyFilters();
                      },
                    ),
                    ...languages.map(
                      (lang) => _FilterChip(
                        label: lang,
                        isSelected:
                            _selectedLanguage == lang,
                        onTap: () {
                          setState(
                            () => _selectedLanguage = lang,
                          );
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Age Group ──
              Text(
                'Age Group',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'All Ages',
                      isSelected: _selectedAgeGroup == null,
                      onTap: () {
                        setState(
                          () => _selectedAgeGroup = null,
                        );
                        _applyFilters();
                      },
                    ),
                    ...['3-6', '7-12', '13+', 'adults']
                        .map(
                      (age) => _FilterChip(
                        label: age,
                        isSelected:
                            _selectedAgeGroup == age,
                        onTap: () {
                          setState(
                            () => _selectedAgeGroup = age,
                          );
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // ── Clear Filters ──
              if (_hasActiveFilters())
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _clearAllFilters,
                    icon: const Icon(
                      Icons.clear_all,
                      size: 18,
                    ),
                    label: const Text('Clear All'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red.shade400,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // BOOK GRID
  // ─────────────────────────────────────────

  Widget _buildBookGrid(ExploreLoaded state) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (state.hasMore && !state.isLoadingMore) {
          context
              .read<ExploreBloc>()
              .add(LoadMoreExplore());
        }
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ExploreBloc>()
            .add(LoadExploreData());
      },
      child: GridView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding:
            const EdgeInsets.fromLTRB(20, 8, 20, 100),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
        ),
        itemCount:
            state.books.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.books.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final book = state.books[index];
          return _ExploreBookCard(
            book: book,
            onTap: () => context.push(
              '/book/${book.id}',
              extra: book,
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // SHIMMER
  // ─────────────────────────────────────────

  Widget _buildGridShimmer() {
    return GridView.builder(
      padding:
          const EdgeInsets.fromLTRB(20, 8, 20, 100),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 14,
                width: 120,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                height: 12,
                width: 80,
                color: Colors.white,
              ),
            ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/empty_search.json',
            width: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'No books found',
            style: AppTypography.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or filters',
            style: AppTypography.bodyMedium
                .copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          if (_hasActiveFilters())
            OutlinedButton.icon(
              onPressed: _clearAllFilters,
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear Filters'),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // ERROR STATE
  // ─────────────────────────────────────────

  Widget _buildGridError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: AppTypography.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTypography.bodyMedium
                .copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context
                .read<ExploreBloc>()
                .add(LoadExploreData()),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _FilterChip
// ─────────────────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.grey.shade700,
              fontWeight: isSelected
                  ? FontWeight.w700
                  : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _ExploreBookCard
// ─────────────────────────────────────────────────────────────────────────────

class _ExploreBookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  const _ExploreBookCard({
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover ──
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: 'book-cover-${book.id}',
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: book.coverImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.book,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) =>
                            Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Premium Badge
                if (book.isPremium)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '⭐ PRO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                // Free Badge
                if (book.isFree)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                // Rating
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.black.withOpacity(0.7),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          book.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // ── Title ──
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),

          // ── Author ──
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}