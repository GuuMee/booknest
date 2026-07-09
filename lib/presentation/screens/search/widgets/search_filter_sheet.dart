// lib/presentation/screens/search/widgets/search_filter_sheet.dart

import 'package:flutter/material.dart';              // StatefulWidget, Widget,
                                                     // RangeValues, RangeSlider
                                                     // SliderTheme, SliderThemeData
                                                     // RoundRangeSliderThumbShape
                                                     // DraggableScrollableSheet
                                                     // Switch, Colors, etc.
import 'package:flutter_bloc/flutter_bloc.dart';     // context.read<>()

// Presentation - BLoC - Search
import '../../../bloc/search/search_bloc.dart';       // SearchBloc
import '../../../bloc/search/search_state.dart';      // SearchResults
import '../../../bloc/search/search_event.dart';      // ApplyFilters

// Domain - Models
import '../../../../domain/models/search_filters.dart'; // SearchFilters
                                                        // .sortBy
                                                        // .ratingRange
                                                        // .categories
                                                        // .freeOnly

// Core - Theme
import '../../../../core/theme/app_colors.dart';     // AppColors.primary

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class SearchFilterSheet extends StatefulWidget {
  const SearchFilterSheet({super.key});

  @override
  State<SearchFilterSheet> createState() =>
      _SearchFilterSheetState();
}

class _SearchFilterSheetState
    extends State<SearchFilterSheet> {
  // ─────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────

  String _sortBy = 'relevance';
  RangeValues _ratingRange =
      const RangeValues(0, 5);
  Set<String> _selectedCategories = {};
  bool _freeOnly = false;

  // ─────────────────────────────────────────
  // STATIC DATA
  // ─────────────────────────────────────────

  final List<String> _categories = [
    'Fiction',
    'Non-Fiction',
    'Science',
    'Technology',
    'Business',
    'Self-Help',
    'History',
    'Philosophy',
    'Biography',
    'Education',
    'Health',
    'Arts',
  ];

  final List<Map<String, String>> _sortOptions = [
    {'id': 'relevance', 'label': 'Most Relevant'},
    {'id': 'rating', 'label': 'Highest Rated'},
    {'id': 'newest', 'label': 'Newest First'},
    {'id': 'popular', 'label': 'Most Popular'},
    {'id': 'title_asc', 'label': 'Title A-Z'},
    {'id': 'title_desc', 'label': 'Title Z-A'},
  ];

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    final state = context.read<SearchBloc>().state;
    if (state is SearchResults &&
        state.filters != null) {
      _sortBy = state.filters!.sortBy;
      _ratingRange = state.filters!.ratingRange;
      _selectedCategories =
          state.filters!.categories;
      _freeOnly = state.filters!.freeOnly;
    }
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // ── Handle & Header ───────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                12,
                24,
                0,
              ),
              child: Column(
                children: [
                  // Drag Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title & Reset
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      const Text(
                        'Filter & Sort',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _sortBy = 'relevance';
                            _ratingRange =
                                const RangeValues(
                              0,
                              5,
                            );
                            _selectedCategories =
                                {};
                            _freeOnly = false;
                          });
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Scrollable Content ────────
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                physics:
                    const BouncingScrollPhysics(),
                children: [
                  // ── Sort By ─────────────
                  const Text(
                    'Sort By',
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
                        _sortOptions.map((option) {
                      final isSelected =
                          _sortBy == option['id'];
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () => _sortBy =
                                option['id']!,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          padding: const EdgeInsets
                              .symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors
                                    .grey.shade100,
                            borderRadius:
                                BorderRadius
                                    .circular(20),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors
                                        .grey
                                        .shade200,
                                  ),
                          ),
                          child: Text(
                            option['label']!,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors
                                      .grey.shade700,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),

                  // ── Categories ──────────
                  const Text(
                    'Categories',
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
                        _categories.map((category) {
                      final isSelected =
                          _selectedCategories
                              .contains(category);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories
                                  .remove(category);
                            } else {
                              _selectedCategories
                                  .add(category);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          padding: const EdgeInsets
                              .symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                    .withOpacity(0.1)
                                : Colors
                                    .grey.shade100,
                            borderRadius:
                                BorderRadius
                                    .circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors
                                      .grey.shade200,
                            ),
                          ),
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              if (isSelected) ...[
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: AppColors
                                      .primary,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                              Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors
                                          .primary
                                      : Colors.grey
                                          .shade700,
                                  fontWeight:
                                      FontWeight.w600,
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

                  // ── Rating ──────────────
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      const Text(
                        'Rating',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${_ratingRange.start.toStringAsFixed(1)}'
                        ' - '
                        '${_ratingRange.end.toStringAsFixed(1)}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor:
                          AppColors.primary,
                      inactiveTrackColor:
                          Colors.grey.shade200,
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary
                          .withOpacity(0.1),
                      rangeThumbShape:
                          const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                    ),
                    child: RangeSlider(
                      values: _ratingRange,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      onChanged: (values) {
                        setState(
                          () => _ratingRange = values,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      // Min stars
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: i <
                                    _ratingRange.start
                                        .round()
                                ? Colors.grey.shade300
                                : Colors.amber,
                          ),
                        ),
                      ),
                      // Max stars
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: i <
                                    _ratingRange.end
                                        .round()
                                ? Colors.amber
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── Free Only ───────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius:
                          BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.money_off_rounded,
                          color:
                              Colors.green.shade600,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              const Text(
                                'Free Books Only',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Show only free books',
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          value: _freeOnly,
                          activeColor:
                              AppColors.primary,
                          onChanged: (val) {
                            setState(
                              () => _freeOnly = val,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // ── Apply Button ──────────────
            Container(
              padding: EdgeInsets.fromLTRB(
                24,
                16,
                24,
                MediaQuery.of(context).padding.bottom +
                    16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Active Filters Count Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${_getActiveFilterCount()}'
                      ' active',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Apply Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final filters = SearchFilters(
                          sortBy: _sortBy,
                          ratingRange: _ratingRange,
                          categories:
                              _selectedCategories,
                          freeOnly: _freeOnly,
                        );
                        context
                            .read<SearchBloc>()
                            .add(
                              ApplyFilters(
                                filters: filters,
                              ),
                            );
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primary,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  int _getActiveFilterCount() {
    int count = 0;
    if (_sortBy != 'relevance') count++;
    if (_selectedCategories.isNotEmpty) count++;
    if (_ratingRange.start > 0 ||
        _ratingRange.end < 5) count++;
    if (_freeOnly) count++;
    return count;
  }
}