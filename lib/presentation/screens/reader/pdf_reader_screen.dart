// lib/presentation/screens/reader/pdf_reader_screen.dart

import 'dart:async';                                  // Timer

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';               // SystemChrome, SystemUiMode
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';          // Share.share
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // SfPdfViewer, PdfViewerController, PdfPageLayoutMode
import 'package:screen_brightness/screen_brightness.dart';    // ScreenBrightness
import 'package:timeago/timeago.dart' as timeago;    // timeago.format
import 'package:uuid/uuid.dart';                     // Uuid

// Data - Models
import '../../../data/models/book_model.dart';
import '../../../data/models/bookmark_model.dart';
import '../../../data/models/reading_progress_model.dart';

// Presentation - BLoC - Reader
import '../../blocs/reader/reader_bloc.dart';
import '../../blocs/reader/reader_event.dart';
import '../../blocs/reader/reader_state.dart';

// Core - Theme
import '../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class PdfReaderScreen extends StatefulWidget {
  final BookModel book;
  final ReadingProgressModel? existingProgress;

  const PdfReaderScreen({
    super.key,
    required this.book,
    this.existingProgress,
  });

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen>
    with WidgetsBindingObserver {
  late PdfViewerController _pdfController;
  bool _showControls = true;
  bool _isDarkMode = false;
  double _brightness = 1.0;
  int _currentPage = 1;
  int _totalPages = 0;
  Timer? _autoSaveTimer;
  Timer? _readingTimer;
  int _secondsRead = 0;
  DateTime? _sessionStartTime;

  // Settings
  double _fontSize = 16.0;
  bool _isScrollMode = false;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pdfController = PdfViewerController();

    // Resume from saved progress
    if (widget.existingProgress != null) {
      _currentPage = widget.existingProgress!.currentPage;
      _secondsRead = widget.existingProgress!.totalSecondsRead;
    }

    _sessionStartTime = DateTime.now();
    _startTimers();

    // Hide system UI for immersive reading
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autoSaveTimer?.cancel();
    _readingTimer?.cancel();
    _saveProgress();

    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pdfController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveProgress();
    }
    if (state == AppLifecycleState.resumed) {
      _startTimers();
    }
  }

  // ─────────────────────────────────────────
  // TIMERS & PROGRESS
  // ─────────────────────────────────────────

  void _startTimers() {
    // Auto-save every 30 seconds
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _saveProgress(),
    );

    // Reading timer (count seconds)
    _readingTimer?.cancel();
    _readingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _secondsRead++,
    );
  }

  void _saveProgress() {
    if (_totalPages > 0) {
      context.read<ReaderBloc>().add(
            SaveReadingProgress(
              bookId: widget.book.id,
              currentPage: _currentPage,
              totalPages: _totalPages,
              secondsRead: _secondsRead,
            ),
          );
    }
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : Theme.of(context),
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
        body: Stack(
          children: [
            // ===== PDF VIEWER =====
            GestureDetector(
              onTap: _toggleControls,
              child: _buildPdfViewer(),
            ),

            // ===== TOP BAR =====
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _showControls ? 0 : -120,
              left: 0,
              right: 0,
              child: _buildTopBar(),
            ),

            // ===== BOTTOM BAR =====
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _showControls ? 0 : -160,
              left: 0,
              right: 0,
              child: _buildBottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // PDF VIEWER
  // ─────────────────────────────────────────

  Widget _buildPdfViewer() {
    return BlocBuilder<ReaderBloc, ReaderState>(
      builder: (context, state) {
        String? pdfSource;

        if (state is ReaderReady && state.localPdfPath != null) {
          pdfSource = state.localPdfPath;
        }

        return SfPdfViewer.network(
          pdfSource ?? widget.book.pdfUrl,
          controller: _pdfController,
          initialPageNumber: _currentPage,
          canShowScrollHead: !_showControls,
          canShowScrollStatus: false,
          canShowPaginationDialog: false,
          pageLayoutMode: _isScrollMode
              ? PdfPageLayoutMode.continuous
              : PdfPageLayoutMode.single,
          onDocumentLoaded: (details) {
            setState(() {
              _totalPages = details.document.pages.count;
            });
            if (_currentPage > 1) {
              _pdfController.jumpToPage(_currentPage);
            }
          },
          onPageChanged: (details) {
            setState(() {
              _currentPage = details.newPageNumber;
            });
          },
          onDocumentLoadFailed: (details) {
            _showLoadError(details.description);
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // TOP BAR
  // ─────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        8,
        MediaQuery.of(context).padding.top + 8,
        8,
        12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            (_isDarkMode ? Colors.black : Colors.white).withOpacity(0.95),
            (_isDarkMode ? Colors.black : Colors.white).withOpacity(0.0),
          ],
        ),
      ),
      child: Row(
        children: [
          // Back
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: _isDarkMode ? Colors.white : Colors.black,
              size: 20,
            ),
            onPressed: () {
              _saveProgress();
              Navigator.pop(context);
            },
          ),

          // Book Title
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.book.title,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.book.author,
                  style: TextStyle(
                    color: _isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Bookmark
          BlocBuilder<ReaderBloc, ReaderState>(
            builder: (context, state) {
              final isBookmarked = state is ReaderReady &&
                  state.bookmarks
                      .any((b) => b.pageNumber == _currentPage);
              return IconButton(
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: isBookmarked
                      ? Colors.amber
                      : (_isDarkMode ? Colors.white : Colors.black),
                ),
                onPressed: () {
                  if (isBookmarked) {
                    final bookmark = (state as ReaderReady)
                        .bookmarks
                        .firstWhere(
                            (b) => b.pageNumber == _currentPage);
                    context.read<ReaderBloc>().add(
                          RemoveBookmark(bookmarkId: bookmark.id),
                        );
                  } else {
                    _showAddBookmarkDialog();
                  }
                },
              );
            },
          ),

          // More Options
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'bookmarks',
                child: ListTile(
                  leading: Icon(Icons.bookmark_rounded),
                  title: Text('Bookmarks'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'goto_page',
                child: ListTile(
                  leading: Icon(Icons.find_in_page_rounded),
                  title: Text('Go to Page'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share_rounded),
                  title: Text('Share'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // BOTTOM BAR
  // ─────────────────────────────────────────

  Widget _buildBottomBar() {
    final progressPercent =
        _totalPages > 0 ? (_currentPage / _totalPages) : 0.0;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            (_isDarkMode ? Colors.black : Colors.white).withOpacity(0.95),
            (_isDarkMode ? Colors.black : Colors.white).withOpacity(0.0),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page Slider
          Row(
            children: [
              Text(
                'Page $_currentPage',
                style: TextStyle(
                  color: _isDarkMode
                      ? Colors.white70
                      : Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: _isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                      thumbColor: AppColors.primary,
                      overlayColor:
                          AppColors.primary.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: _currentPage.toDouble(),
                      min: 1,
                      max: _totalPages > 0
                          ? _totalPages.toDouble()
                          : 1,
                      onChanged: (value) {
                        _pdfController.jumpToPage(value.toInt());
                      },
                    ),
                  ),
                ),
              ),
              Text(
                '$_totalPages',
                style: TextStyle(
                  color: _isDarkMode
                      ? Colors.white70
                      : Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress % & time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(progressPercent * 100).toInt()}% complete',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.schedule,
                size: 14,
                color: _isDarkMode ? Colors.white54 : Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                _formatReadingTime(_secondsRead),
                style: TextStyle(
                  color:
                      _isDarkMode ? Colors.white54 : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: _isDarkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                label: _isDarkMode ? 'Light' : 'Dark',
                isActive: _isDarkMode,
                isDarkMode: _isDarkMode,
                onTap: () =>
                    setState(() => _isDarkMode = !_isDarkMode),
              ),
              _ControlButton(
                icon: Icons.brightness_6_rounded,
                label: 'Brightness',
                isDarkMode: _isDarkMode,
                onTap: _showBrightnessSlider,
              ),
              _ControlButton(
                icon: _isScrollMode
                    ? Icons.view_day_rounded
                    : Icons.auto_stories_rounded,
                label: _isScrollMode ? 'Scroll' : 'Page',
                isDarkMode: _isDarkMode,
                onTap: () => setState(
                    () => _isScrollMode = !_isScrollMode),
              ),
              _ControlButton(
                icon: Icons.text_fields_rounded,
                label: 'Text',
                isDarkMode: _isDarkMode,
                onTap: _showTextSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // MENU ACTIONS
  // ─────────────────────────────────────────

  void _handleMenuAction(String action) {
    switch (action) {
      case 'bookmarks':
        _showBookmarksList();
        break;
      case 'goto_page':
        _showGoToPageDialog();
        break;
      case 'share':
        Share.share(
          'I\'m reading "${widget.book.title}" by '
          '${widget.book.author} - '
          'Page $_currentPage/$_totalPages 📚',
        );
        break;
    }
  }

  // ─────────────────────────────────────────
  // ADD BOOKMARK DIALOG
  // ─────────────────────────────────────────

  void _showAddBookmarkDialog() {
    final noteController = TextEditingController();
    final colors = [
      Colors.amber,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
    ];
    Color selectedColor = Colors.amber;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          _isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bookmark Page $_currentPage',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color:
                          _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Color Selection
                  Text(
                    'Color',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isDarkMode
                          ? Colors.white70
                          : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: colors.map((color) {
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setModalState(
                            () => selectedColor = color),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(
                                    color: Colors.white, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color:
                                          color.withOpacity(0.5),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Note
                  Text(
                    'Note (optional)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isDarkMode
                          ? Colors.white70
                          : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    style: TextStyle(
                      color: _isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a note about this page...',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: _isDarkMode
                          ? Colors.grey.shade900
                          : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ReaderBloc>().add(
                              AddBookmark(
                                bookId: widget.book.id,
                                bookmark: BookmarkModel(
                                  id: const Uuid().v4(),
                                  pageNumber: _currentPage,
                                  note: noteController.text.isEmpty
                                      ? null
                                      : noteController.text,
                                  color: selectedColor.value
                                      .toString(),
                                  createdAt: DateTime.now(),
                                ),
                              ),
                            );
                        Navigator.pop(context);
                        _showSnackBar('Bookmark added! 🔖');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save Bookmark',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // BOOKMARKS LIST
  // ─────────────────────────────────────────

  void _showBookmarksList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          _isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.85,
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<ReaderBloc, ReaderState>(
              builder: (context, state) {
                final bookmarks = state is ReaderReady
                    ? state.bookmarks
                    : <BookmarkModel>[];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            'Bookmarks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: _isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(0.15),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${bookmarks.length}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: bookmarks.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bookmark_border_rounded,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No bookmarks yet',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap the bookmark icon to save a page',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              itemCount: bookmarks.length,
                              itemBuilder: (context, index) {
                                final bookmark = bookmarks[index];
                                final color = Color(
                                  int.tryParse(
                                          bookmark.color ?? '') ??
                                      Colors.amber.value,
                                );

                                return Dismissible(
                                  key: Key(bookmark.id),
                                  direction:
                                      DismissDirection.endToStart,
                                  background: Container(
                                    alignment:
                                        Alignment.centerRight,
                                    padding: const EdgeInsets.only(
                                        right: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius:
                                          BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onDismissed: (_) {
                                    context.read<ReaderBloc>().add(
                                          RemoveBookmark(
                                              bookmarkId:
                                                  bookmark.id),
                                        );
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pdfController.jumpToPage(
                                          bookmark.pageNumber);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 12),
                                      padding:
                                          const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: _isDarkMode
                                            ? Colors.grey.shade900
                                            : Colors.grey.shade50,
                                        borderRadius:
                                            BorderRadius.circular(
                                                16),
                                        border: Border(
                                          left: BorderSide(
                                              color: color,
                                              width: 4),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: color
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${bookmark.pageNumber}',
                                                style: TextStyle(
                                                  color: color,
                                                  fontWeight:
                                                      FontWeight.w800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  'Page ${bookmark.pageNumber}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700,
                                                    color: _isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                                if (bookmark.note !=
                                                    null) ...[
                                                  const SizedBox(
                                                      height: 4),
                                                  Text(
                                                    bookmark.note!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .grey.shade500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                                const SizedBox(
                                                    height: 4
                                                                                                    Text(
                                                  timeago.format(
                                                    bookmark.createdAt,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors
                                                        .grey.shade400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey.shade400,
                                          ),
                                        ],
                                      ),
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
      },
    );
  }

  // ─────────────────────────────────────────
  // GO TO PAGE DIALOG
  // ─────────────────────────────────────────

  void _showGoToPageDialog() {
    final pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              _isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Go to Page',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '1 - $_totalPages',
              hintStyle: TextStyle(
                  color: Colors.grey.shade500, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onSubmitted: (value) {
              final page = int.tryParse(value);
              if (page != null &&
                  page >= 1 &&
                  page <= _totalPages) {
                Navigator.pop(context);
                _pdfController.jumpToPage(page);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final page =
                    int.tryParse(pageController.text);
                if (page != null &&
                    page >= 1 &&
                    page <= _totalPages) {
                  Navigator.pop(context);
                  _pdfController.jumpToPage(page);
                } else {
                  _showSnackBar(
                      'Please enter a valid page number');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go'),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // BRIGHTNESS SLIDER
  // ─────────────────────────────────────────

  void _showBrightnessSlider() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          _isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Screen Brightness',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_low,
                        color: _isDarkMode
                            ? Colors.white54
                            : Colors.grey,
                      ),
                      Expanded(
                        child: Slider(
                          value: _brightness,
                          min: 0.1,
                          max: 1.0,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setModalState(
                                () => _brightness = value);
                            setState(() {});
                            ScreenBrightness()
                                .setScreenBrightness(value);
                          },
                        ),
                      ),
                      Icon(
                        Icons.brightness_high,
                        color: _isDarkMode
                            ? Colors.white54
                            : Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // TEXT SETTINGS
  // ─────────────────────────────────────────

  void _showTextSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          _isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reading Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Page Layout ──
                  Text(
                    'Page Layout',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isDarkMode
                          ? Colors.white70
                          : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {});
                            setState(
                                () => _isScrollMode = false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            decoration: BoxDecoration(
                              color: !_isScrollMode
                                  ? AppColors.primary
                                  : (_isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade100),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.auto_stories_rounded,
                                  color: !_isScrollMode
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Page Flip',
                                  style: TextStyle(
                                    color: !_isScrollMode
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {});
                            setState(() => _isScrollMode = true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            decoration: BoxDecoration(
                              color: _isScrollMode
                                  ? AppColors.primary
                                  : (_isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade100),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.view_day_rounded,
                                  color: _isScrollMode
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Scroll',
                                  style: TextStyle(
                                    color: _isScrollMode
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Theme ──
                  Text(
                    'Theme',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isDarkMode
                          ? Colors.white70
                          : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      _ThemeOption(
                        label: 'Light',
                        bgColor: Colors.white,
                        textColor: Colors.black,
                        isSelected: !_isDarkMode,
                        onTap: () {
                          setModalState(() {});
                          setState(() => _isDarkMode = false);
                        },
                      ),
                      _ThemeOption(
                        label: 'Dark',
                        bgColor: const Color(0xFF1A1A2E),
                        textColor: Colors.white,
                        isSelected: _isDarkMode,
                        onTap: () {
                          setModalState(() {});
                          setState(() => _isDarkMode = true);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).padding.bottom +
                            16,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // LOAD ERROR DIALOG
  // ─────────────────────────────────────────

  void _showLoadError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Failed to Load PDF'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // SNACKBAR
  // ─────────────────────────────────────────

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─────────────────────────────────────────
  // UTILS
  // ─────────────────────────────────────────

  String _formatReadingTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _ControlButton
// ─────────────────────────────────────────────────────────────────────────────

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withOpacity(0.15)
                  : (isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: isActive
                  ? AppColors.primary
                  : (isDarkMode
                      ? Colors.white70
                      : Colors.grey.shade700),
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white54
                  : Colors.grey.shade600,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _ThemeOption
// ─────────────────────────────────────────────────────────────────────────────

class _ThemeOption extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Aa',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}