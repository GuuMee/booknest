// lib/presentation/screens/reader/reader_screen.dart

import 'dart:async';                                  // Timer
                                                      // Timer.periodic()

import 'package:flutter/material.dart';               // StatefulWidget, State
                                                      // TickerProviderStateMixin
                                                      // WidgetsBindingObserver
                                                      // AnimationController
                                                      // CurvedAnimation
                                                      // Animation<double>
                                                      // FadeTransition
                                                      // Scaffold, Stack
                                                      // GestureDetector
                                                      // LinearProgressIndicator
                                                      // Colors, Icons, etc.

import 'package:flutter/services.dart';               // SystemChrome
                                                      // SystemUiMode
                                                      // .edgeToEdge
                                                      // .immersiveSticky

import 'package:flutter_bloc/flutter_bloc.dart';      // BlocConsumer
                                                      // context.read<>()

import 'package:wakelock_plus/wakelock_plus.dart';    // WakelockPlus.enable()

// Presentation - BLoC - Reader
import '../../bloc/reader/reader_bloc.dart';          // ReaderBloc
import '../../bloc/reader/reader_state.dart';         // ReaderState
                                                      // ReaderLoading
                                                      // ReaderLoaded
                                                      // ReaderError
import '../../bloc/reader/reader_event.dart';         // LoadBook
                                                      // SaveReadingProgress
                                                      // NavigateToChapter
                                                      // ToggleBookmark
                                                      // JumpToPage
                                                      // UpdateReaderSettings

// Presentation - BLoC - Stats
import '../../bloc/stats/stats_bloc.dart';            // StatsBloc
import '../../bloc/stats/stats_event.dart';           // RecordReadingSession

// Presentation - Screens - Reader - Widgets
import 'widgets/book_content_view.dart';              // _BookContentView
import 'widgets/top_controls.dart';                   // _TopControls
import 'widgets/bottom_controls.dart';                // _BottomControls
import 'widgets/reader_settings_sheet.dart';          // _ReaderSettingsSheet

// Domain - Models
import '../../../domain/models/reading_theme_colors.dart'; // ReadingThemeColors
                                                           // .background
                                                           // .text
                                                           // .controlsBg
                                                           // .accent

// Core - Theme
import '../../../core/theme/app_colors.dart';         // AppColors.primary

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class ReaderScreen extends StatefulWidget {
  final String bookId;
  const ReaderScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<ReaderScreen> createState() =>
      _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen>
    with
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  // ─────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────

  bool _showControls = false;
  late AnimationController _controlsController;
  late Animation<double> _controlsAnimation;
  Timer? _readingTimer;
  int _secondsRead = 0;
  DateTime? _sessionStart;

  // Page tracking
  int _currentPage = 0;
  int _totalPages = 0;
  double _progress = 0.0;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controlsController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
    _controlsAnimation = CurvedAnimation(
      parent: _controlsController,
      curve: Curves.easeOut,
    );

    // Load book
    context.read<ReaderBloc>().add(
      LoadBook(bookId: widget.bookId),
    );

    // Start reading session
    _startReadingSession();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controlsController.dispose();
    _endReadingSession();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    if (state == AppLifecycleState.paused) {
      _pauseReadingSession();
    } else if (state ==
        AppLifecycleState.resumed) {
      _resumeReadingSession();
    }
  }

  // ─────────────────────────────────────────
  // SESSION
  // ─────────────────────────────────────────

  void _startReadingSession() {
    _sessionStart = DateTime.now();
    _readingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _secondsRead++;
      },
    );
  }

  void _pauseReadingSession() {
    _readingTimer?.cancel();
    _saveProgress();
  }

  void _resumeReadingSession() {
    _readingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _secondsRead++;
      },
    );
  }

  void _endReadingSession() {
    _readingTimer?.cancel();
    _saveProgress();

    if (_secondsRead > 10) {
      context.read<StatsBloc>().add(
        RecordReadingSession(
          bookId: widget.bookId,
          durationSeconds: _secondsRead,
          pagesRead: _currentPage,
          date: DateTime.now(),
        ),
      );
    }
  }

  void _saveProgress() {
    context.read<ReaderBloc>().add(
      SaveReadingProgress(
        bookId: widget.bookId,
        currentPage: _currentPage,
        totalPages: _totalPages,
        progress: _progress,
      ),
    );
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _controlsController.forward();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
        );
      } else {
        _controlsController.reverse();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
        );
      }
    });
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReaderBloc, ReaderState>(
      listener: (context, state) {
        if (state is ReaderLoaded) {
          _currentPage = state.currentPage;
          _totalPages = state.totalPages;
          _progress = state.progress;

          // Apply settings
          if (state.settings.keepScreenOn) {
            WakelockPlus.enable();
          }
        }
        if (state is ReaderError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ReaderLoading) {
          return _buildLoadingScreen();
        }
        if (state is ReaderLoaded) {
          return _buildReaderScreen(state);
        }
        if (state is ReaderError) {
          return _buildErrorScreen(
            state.message,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // ─────────────────────────────────────────
  // SCREEN BUILDERS
  // ─────────────────────────────────────────

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Preparing your book...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style:
                  const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ReaderBloc>()
                    .add(
                      LoadBook(
                        bookId: widget.bookId,
                      ),
                    );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReaderScreen(
    ReaderLoaded state,
  ) {
    final readingTheme =
        _getReadingThemeColors(
      state.settings.readingTheme,
    );

    return Scaffold(
      backgroundColor: readingTheme.background,
      body: Stack(
        children: [
          // ===== BOOK CONTENT =====
          GestureDetector(
            onTap: _toggleControls,
            child: _BookContentView(
              book: state.book,
              chapters: state.chapters,
              currentChapter:
                  state.currentChapter,
              currentPage: state.currentPage,
              fontSize: state.settings.fontSize,
              lineSpacing:
                  state.settings.lineSpacing,
              textColor: readingTheme.text,
              backgroundColor:
                  readingTheme.background,
              onPageChanged:
                  (page, total, progress) {
                setState(() {
                  _currentPage = page;
                  _totalPages = total;
                  _progress = progress;
                });
              },
              onChapterChanged:
                  (chapterIndex) {
                context
                    .read<ReaderBloc>()
                    .add(
                      NavigateToChapter(
                        index: chapterIndex,
                      ),
                    );
              },
            ),
          ),

          // ===== TOP CONTROLS =====
          if (_showControls)
            FadeTransition(
              opacity: _controlsAnimation,
              child: _TopControls(
                book: state.book,
                onBack: () {
                  _saveProgress();
                  Navigator.pop(context);
                },
                onBookmark: () {
                  context
                      .read<ReaderBloc>()
                      .add(
                        ToggleBookmark(
                          bookId:
                              widget.bookId,
                          page: _currentPage,
                          chapter:
                              state.currentChapter,
                        ),
                      );
                },
                onTableOfContents: () {
                  _showTableOfContents(
                    context,
                    state,
                  );
                },
                isBookmarked:
                    state.isCurrentPageBookmarked,
                backgroundColor:
                    readingTheme.controlsBg,
                textColor: readingTheme.text,
              ),
            ),

          // ===== BOTTOM CONTROLS =====
          if (_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _controlsAnimation,
                child: _BottomControls(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  progress: _progress,
                  chapterTitle:
                      state.currentChapterTitle,
                  secondsRead: _secondsRead,
                  onSettingsTap: () =>
                      _showReaderSettings(
                    context,
                    state,
                  ),
                  onSliderChanged: (value) {
                    final page =
                        (value * _totalPages)
                            .round();
                    context
                        .read<ReaderBloc>()
                        .add(
                          JumpToPage(
                            page: page,
                          ),
                        );
                  },
                  backgroundColor:
                      readingTheme.controlsBg,
                  textColor: readingTheme.text,
                  accentColor:
                      readingTheme.accent,
                ),
              ),
            ),

          // ===== PROGRESS BAR (always visible) =====
          if (!_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor:
                    Colors.transparent,
                valueColor:
                    AlwaysStoppedAnimation(
                  AppColors.primary
                      .withOpacity(0.5),
                ),
                minHeight: 2,
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  ReadingThemeColors _getReadingThemeColors(
    String theme,
  ) {
    switch (theme) {
      case 'sepia':
        return ReadingThemeColors(
          background:
              const Color(0xFFF5E6C8),
          text: const Color(0xFF5B4636),
          controlsBg:
              const Color(0xFFE8D5B0),
          accent: const Color(0xFF8B6914),
        );
      case 'dark':
        return ReadingThemeColors(
          background:
              const Color(0xFF1A1A2E),
          text: const Color(0xFFE0E0E0),
          controlsBg:
              const Color(0xFF16213E),
          accent: const Color(0xFF64B5F6),
        );
      case 'amoled':
        return ReadingThemeColors(
          background: Colors.black,
          text: Colors.white70,
          controlsBg:
              const Color(0xFF111111),
          accent: const Color(0xFF90CAF9),
        );
      default: // light
        return ReadingThemeColors(
          background: Colors.white,
          text: Colors.black87,
          controlsBg: Colors.white,
          accent: AppColors.primary,
        );
    }
  }

  // ─────────────────────────────────────────
  // BOTTOM SHEETS
  // ─────────────────────────────────────────

  void _showTableOfContents(
    BuildContext context,
    ReaderLoaded state,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder:
              (context, scrollController) {
            return Column(
              children: [
                // Handle
                Padding(
                  padding:
                      const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors
                          .grey.shade300,
                      borderRadius:
                          BorderRadius
                              .circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Table of Contents',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),

                // Chapters
                Expanded(
                  child: ListView.builder(
                    controller:
                        scrollController,
                    padding: const EdgeInsets
                        .symmetric(
                      horizontal: 20,
                    ),
                    itemCount:
                        state.chapters.length,
                    itemBuilder:
                        (context, index) {
                      final chapter =
                          state.chapters[index];
                      final isCurrent =
                          index ==
                              state.currentChapter;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                          context
                              .read<
                                  ReaderBloc>()
                              .add(
                                NavigateToChapter(
                                  index: index,
                                ),
                              );
                        },
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          margin:
                              const EdgeInsets
                                  .only(
                            bottom: 4,
                          ),
                          decoration:
                              BoxDecoration(
                            color: isCurrent
                                ? AppColors
                                    .primary
                                    .withOpacity(
                                    0.08,
                                  )
                                : Colors
                                    .transparent,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Chapter number
                              Container(
                                width: 32,
                                height: 32,
                                decoration:
                                    BoxDecoration(
                                  color: isCurrent
                                      ? AppColors
                                          .primary
                                      : Colors
                                          .grey
                                          .shade200,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    8,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style:
                                        TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      fontSize:
                                          13,
                                      color: isCurrent
                                          ? Colors
                                              .white
                                          : Colors
                                              .grey
                                              .shade600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      chapter
                                          .title,
                                      style:
                                          TextStyle(
                                        fontWeight: isCurrent
                                            ? FontWeight
                                                .w700
                                            : FontWeight
                                                .w500,
                                        fontSize:
                                            15,
                                        color: isCurrent
                                            ? AppColors
                                                .primary
                                            : Colors
                                                .black87,
                                      ),
                                    ),
                                    if (chapter
                                            .subtitle !=
                                        null)
                                      Text(
                                        chapter
                                            .subtitle!,
                                        style:
                                            TextStyle(
                                          fontSize:
                                              12,
                                          color: Colors
                                              .grey
                                              .shade500,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (isCurrent)
                                Container(
                                  padding: const EdgeInsets
                                      .symmetric(
                                    horizontal:
                                        8,
                                    vertical: 4,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: AppColors
                                        .primary
                                        .withOpacity(
                                      0.1,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      8,
                                    ),
                                  ),
                                  child: Text(
                                    'Current',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          10,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      color: AppColors
                                          .primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showReaderSettings(
    BuildContext context,
    ReaderLoaded state,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return _ReaderSettingsSheet(
          settings: state.settings,
          onSettingsChanged: (settings) {
            context.read<ReaderBloc>().add(
              UpdateReaderSettings(
                settings: settings,
              ),
            );
          },
        );
      },
    );
  }
}