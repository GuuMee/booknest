// lib/presentation/screens/reader/widgets/book_content_view.dart

import 'package:flutter/foundation.dart';          // compute()

import 'package:flutter/material.dart';             // StatefulWidget, State
                                                    // Widget, BuildContext
                                                    // ValueChanged<T>
                                                    // Color
                                                    // MediaQuery
                                                    // PageController
                                                    // PageView
                                                    // BouncingScrollPhysics
                                                    // Center
                                                    // CircularProgressIndicator
                                                    // Padding, EdgeInsets
                                                    // SelectableText
                                                    // TextStyle

// Domain - Models
import '../../../../domain/models/book.dart';       // Book

import '../../../../domain/models/chapter.dart';    // Chapter
                                                    // .content

// ─────────────────────────────────────────────────────────────────────────────

class _BookContentView extends StatefulWidget {
  final Book book;
  final List<Chapter> chapters;
  final int currentChapter;
  final int currentPage;
  final double fontSize;
  final double lineSpacing;
  final Color textColor;
  final Color backgroundColor;
  final Function(int page, int total, double progress) onPageChanged;
  final ValueChanged<int> onChapterChanged;

  const _BookContentView({
    required this.book,
    required this.chapters,
    required this.currentChapter,
    required this.currentPage,
    required this.fontSize,
    required this.lineSpacing,
    required this.textColor,
    required this.backgroundColor,
    required this.onPageChanged,
    required this.onChapterChanged,
  });

  @override
  State<_BookContentView> createState() =>
      _BookContentViewState();
}

class _BookContentViewState
    extends State<_BookContentView> {
  late PageController _pageController;
  List<String> _pages = [];
  bool _isPaginating = false;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.currentPage,
    );
    _paginateContent();
  }

  @override
  void didUpdateWidget(
    covariant _BookContentView oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fontSize != widget.fontSize ||
        oldWidget.lineSpacing != widget.lineSpacing) {
      _paginateContent();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────
  // PAGINATION
  // ─────────────────────────────────────────

  Future<void> _paginateContent() async {
    setState(() => _isPaginating = true);

    // Get full content from all chapters
    final fullContent = widget.chapters
        .map((c) => c.content)
        .join('\n\n');

    // Paginate based on screen size and font settings
    final pages = await compute(
      _paginateText,
      _PaginationParams(
        content: fullContent,
        fontSize: widget.fontSize,
        lineHeight: widget.lineSpacing,
        pageWidth:
            MediaQuery.of(context).size.width - 48,
        pageHeight:
            MediaQuery.of(context).size.height - 120,
      ),
    );

    setState(() {
      _pages = pages;
      _isPaginating = false;
    });

    // Report total pages
    widget.onPageChanged(
      widget.currentPage,
      _pages.length,
      _pages.isEmpty
          ? 0.0
          : widget.currentPage / _pages.length,
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  int _getChapterPageCount(int chapterIndex) {
    // Approximate based on content length ratios
    final chapter = widget.chapters[chapterIndex];
    final totalLength = widget.chapters.fold(
      0,
      (sum, c) => sum + c.content.length,
    );
    final ratio =
        chapter.content.length / totalLength;
    return (ratio * _pages.length)
        .round()
        .clamp(1, _pages.length);
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_isPaginating || _pages.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: widget.textColor.withOpacity(0.5),
        ),
      );
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (page) {
        final progress = page / _pages.length;
        widget.onPageChanged(
          page,
          _pages.length,
          progress,
        );

        // Determine which chapter we're in
        int totalPages = 0;
        for (int i = 0;
            i < widget.chapters.length;
            i++) {
          final chapterPages =
              _getChapterPageCount(i);
          totalPages += chapterPages;
          if (page < totalPages) {
            if (i != widget.currentChapter) {
              widget.onChapterChanged(i);
            }
            break;
          }
        }
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: SelectableText(
            _pages[index],
            style: TextStyle(
              fontSize: widget.fontSize,
              height: widget.lineSpacing,
              color: widget.textColor,
              fontFamily: 'Merriweather',
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ISOLATE
// ─────────────────────────────────────────────────────────────────────────────

class _PaginationParams {
  final String content;
  final double fontSize;
  final double lineHeight;
  final double pageWidth;
  final double pageHeight;

  _PaginationParams({
    required this.content,
    required this.fontSize,
    required this.lineHeight,
    required this.pageWidth,
    required this.pageHeight,
  });
}

List<String> _paginateText(_PaginationParams params) {
  final pages = <String>[];
  final words = params.content.split(' ');
  final charsPerLine =
      (params.pageWidth / (params.fontSize * 0.55))
          .floor();
  final linesPerPage = (params.pageHeight /
          (params.fontSize * params.lineHeight))
      .floor();
  final charsPerPage = charsPerLine * linesPerPage;

  StringBuffer currentPage = StringBuffer();
  int currentLength = 0;

  for (final word in words) {
    if (currentLength + word.length + 1 >
        charsPerPage) {
      pages.add(currentPage.toString().trim());
      currentPage = StringBuffer();
      currentLength = 0;
    }
    currentPage.write('$word ');
    currentLength += word.length + 1;
  }

  if (currentPage.isNotEmpty) {
    pages.add(currentPage.toString().trim());
  }

  return pages;
}