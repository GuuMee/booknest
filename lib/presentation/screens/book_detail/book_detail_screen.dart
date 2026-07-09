// lib/presentation/screens/book_detail/book_detail_screen.dart

import 'dart:ui';                                    // ImageFilter.blur

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';           // context.push
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';         // Share.share
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;   // timeago.format
import 'package:intl/intl.dart';                    // DateFormat

// Data - Models
import '../../../data/models/book_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/reading_progress_model.dart';

// Presentation - BLoC - BookDetail
import '../../blocs/book_detail/book_detail_bloc.dart';
import '../../blocs/book_detail/book_detail_event.dart';
import '../../blocs/book_detail/book_detail_state.dart';

// Presentation - BLoC - Books (download)
import '../../blocs/books/books_bloc.dart';
import '../../blocs/books/books_event.dart';
import '../../blocs/books/books_state.dart';

// Presentation - Widgets
import '../../widgets/book_card.dart';

// Core - Theme
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class BookDetailScreen extends StatefulWidget {
  final String bookId;
  final BookModel? book;

  const BookDetailScreen({
    super.key,
    required this.bookId,
    this.book,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isExpanded = false;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    context
        .read<BookDetailBloc>()
        .add(LoadBookDetail(bookId: widget.bookId));
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          final book = widget.book ??
              (state is BookDetailLoaded ? state.book : null);

          if (book == null && state is BookDetailLoading) {
            return _buildLoadingState();
          }

          if (book == null) {
            return _buildErrorState();
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ===== HERO COVER HEADER =====
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                stretch: true,
                backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                leading: _buildBackButton(),
                actions: [
                  _buildShareButton(book),
                  _buildFavoriteButton(state),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildCoverSection(book),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                ),
              ),

              // ===== BOOK INFO =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        book.title,
                        style: AppTypography.heading1
                            .copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 8),

                      // Author
                      GestureDetector(
                        onTap: () => context
                            .push('/author/${book.authorId}'),
                        child: Text(
                          'by ${book.author}',
                          style:
                              AppTypography.bodyLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Rating & Stats Row
                      _buildStatsRow(book),
                      const SizedBox(height: 20),

                      // Tags / Categories
                      _buildTags(book),
                      const SizedBox(height: 24),

                      // Description
                      _buildDescription(book),
                      const SizedBox(height: 24),

                      // Book Details Table
                      _buildDetailsTable(book),
                      const SizedBox(height: 24),

                      // Reviews Section
                      if (state is BookDetailLoaded)
                        _buildReviewsSection(state.reviews),

                      // Similar Books
                      if (state is BookDetailLoaded)
                        _buildSimilarBooks(
                            state.similarBooks),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // ===== BOTTOM ACTION BAR =====
      bottomNavigationBar:
          BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          final book = widget.book ??
              (state is BookDetailLoaded ? state.book : null);
          if (book == null) return const SizedBox.shrink();
          return _buildBottomBar(book, state);
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // APP BAR BUTTONS
  // ─────────────────────────────────────────

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildShareButton(BookModel book) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.share_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          Share.share(
            'Check out "${book.title}" by '
            '${book.author} on BookNest! 📚',
          );
        },
      ),
    );
  }

  Widget _buildFavoriteButton(BookDetailState state) {
    final isFavorite =
        state is BookDetailLoaded ? state.isFavorite : false;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: isFavorite ? Colors.red : Colors.white,
          size: 22,
        ),
        onPressed: () {
          context.read<BookDetailBloc>().add(
                ToggleBookFavorite(bookId: widget.bookId),
              );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // COVER SECTION
  // ─────────────────────────────────────────

  Widget _buildCoverSection(BookModel book) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Blurred Background
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: book.coverImageUrl,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

          // Centered Book Cover
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Hero(
                tag: 'book-cover-${book.id}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: book.coverImageUrl,
                      width: 180,
                      height: 260,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: 180,
                        height: 260,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
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
              top: MediaQuery.of(context).padding.top + 60,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Premium',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // STATS ROW
  // ─────────────────────────────────────────

  Widget _buildStatsRow(BookModel book) {
    return Row(
      children: [
        // Rating
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                book.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                ' (${_formatCount(book.ratingCount)})',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        _StatChip(
          icon: Icons.auto_stories_outlined,
          label: '${book.totalPages} pages',
        ),
        const SizedBox(width: 12),

        _StatChip(
          icon: Icons.schedule_rounded,
          label: '${book.estimatedReadTimeMinutes} min',
        ),
        const SizedBox(width: 12),

        _StatChip(
          icon: Icons.storage_rounded,
          label: '${book.fileSizeMB} MB',
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // TAGS
  // ─────────────────────────────────────────

  Widget _buildTags(BookModel book) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: book.categories.map((category) {
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─────────────────────────────────────────
  // DESCRIPTION
  // ─────────────────────────────────────────

  Widget _buildDescription(BookModel book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this book', style: AppTypography.heading3),
        const SizedBox(height: 12),
        AnimatedCrossFade(
          firstChild: Text(
            book.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
          secondChild: Text(
            book.description,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () =>
              setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? 'Show Less' : 'Read More',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // DETAILS TABLE
  // ─────────────────────────────────────────

  Widget _buildDetailsTable(BookModel book) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Book Details', style: AppTypography.heading3),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Publisher',
            value: book.publisher ?? 'Unknown',
          ),
          _DetailRow(
            label: 'Published',
            value: _formatDate(book.publishedDate),
          ),
          _DetailRow(
            label: 'Language',
            value: book.language,
          ),
          _DetailRow(
            label: 'ISBN',
            value: book.isbn ?? 'N/A',
          ),
          _DetailRow(
            label: 'Age Group',
            value: book.ageGroup ?? 'All Ages',
          ),
          _DetailRow(label: 'Format', value: 'PDF'),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // REVIEWS SECTION
  // ─────────────────────────────────────────

  Widget _buildReviewsSection(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: AppTypography.heading3),
            TextButton(
              onPressed: () => context
                  .push('/book/${widget.bookId}/reviews'),
              child: Text(
                'See All (${reviews.length})',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...reviews
            .take(3)
            .map((review) => _ReviewCard(review: review)),
        const SizedBox(height: 24),
      ],
    );
  }

  // ─────────────────────────────────────────
  // SIMILAR BOOKS
  // ─────────────────────────────────────────

  Widget _buildSimilarBooks(List<BookModel> books) {
    if (books.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Also Like',
          style: AppTypography.heading3,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(
                book: books[index],
                onTap: () {
                  context.push(
                    '/book/${books[index].id}',
                    extra: books[index],
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
  // BOTTOM BAR
  // ─────────────────────────────────────────

  Widget _buildBottomBar(
      BookModel book, BookDetailState state) {
    final hasAccess = !book.isPremium ||
        (state is BookDetailLoaded && state.hasSubscription);
    final isDownloaded =
        state is BookDetailLoaded && state.isDownloaded;
    final progress =
        state is BookDetailLoaded ? state.readingProgress : null;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Download Button
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: BlocBuilder<BooksBloc, BooksState>(
              builder: (context, downloadState) {
                final isDownloading =
                    downloadState is BookDownloading &&
                        downloadState.bookId == book.id;

                return IconButton(
                  onPressed: isDownloading
                      ? null
                      : () {
                          if (isDownloaded) {
                            _showDownloadOptions(book);
                          } else if (hasAccess) {
                            context
                                .read<BooksBloc>()
                                .add(DownloadBook(book: book));
                          } else {
                            context.push('/subscription');
                          }
                        },
                  icon: isDownloading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            value: (downloadState
                                    as BookDownloading)
                                .progress,
                            strokeWidth: 2.5,
                            color: AppColors.primary,
                          ),
                        )
                      : Icon(
                          isDownloaded
                              ? Icons.download_done_rounded
                              : Icons.download_rounded,
                          color: isDownloaded
                              ? AppColors.success
                              : AppColors.primary,
                        ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),

          // Main Action Button
          Expanded(
            child: hasAccess
                ? _buildReadButton(book, progress)
                : _buildSubscribeButton(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // READ BUTTON
  // ─────────────────────────────────────────

  Widget _buildReadButton(
      BookModel book, ReadingProgressModel? progress) {
    final isStarted =
        progress != null && progress.progressPercent > 0;
    final isCompleted = progress?.isCompleted ?? false;

    return ElevatedButton(
      onPressed: () {
        context.push(
          '/reader/${book.id}',
          extra: {
            'book': book,
            'progress': progress,
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isCompleted
                ? Icons.replay_rounded
                : (isStarted
                    ? Icons.play_arrow_rounded
                    : Icons.menu_book_rounded),
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            isCompleted
                ? 'Read Again'
                : (isStarted
                    ? 'Continue Reading '
                        '(${progress!.progressPercent.toInt()}%)'
                    : 'Start Reading'),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // SUBSCRIBE BUTTON
  // ─────────────────────────────────────────

  Widget _buildSubscribeButton() {
    return ElevatedButton(
      onPressed: () => context.push('/subscription'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_rounded, size: 22),
          SizedBox(width: 8),
          Text(
            'Subscribe to Read',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // DOWNLOAD OPTIONS SHEET
  // ─────────────────────────────────────────

  void _showDownloadOptions(BookModel book) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.download_done_rounded,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                'Book Downloaded',
                style: AppTypography.heading3,
              ),
              const SizedBox(height: 8),
              Text(
                'This book is available offline',
                style: AppTypography.bodyMedium
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
                title: const Text('Delete Download'),
                subtitle:
                    Text('Free up ${book.fileSizeMB} MB'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteDownload(book);
                },
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────
  // CONFIRM DELETE DIALOG
  // ─────────────────────────────────────────

  void _confirmDeleteDownload(BookModel book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Delete Download?'),
        content: const Text(
          'You can always download it again later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<BookDetailBloc>().add(
                    DeleteBookDownload(bookId: book.id),
                  );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // LOADING STATE
  // ─────────────────────────────────────────

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 380, color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 28,
                    width: 250,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 18,
                    width: 150,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 36,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // ERROR STATE
  // ─────────────────────────────────────────

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load book',
            style: AppTypography.heading3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<BookDetailBloc>().add(
                    LoadBookDetail(bookId: widget.bookId),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // UTILS
  // ─────────────────────────────────────────

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return DateFormat('MMMM d, yyyy').format(date);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _StatChip
// ─────────────────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
                Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _DetailRow
// ─────────────────────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGET — _ReviewCard
// ─────────────────────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 18,
                backgroundImage: review.userAvatarUrl != null
                    ? CachedNetworkImageProvider(
                        review.userAvatarUrl!,
                      )
                    : null,
                child: review.userAvatarUrl == null
                    ? Text(
                        review.userName[0].toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Name & Date
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      timeago.format(review.createdAt),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Star Rating
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ],
          ),

          // Review Text
          if (review.text != null &&
              review.text!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.text!,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}