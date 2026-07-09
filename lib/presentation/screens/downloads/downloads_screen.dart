// lib/presentation/screens/downloads/downloads_screen.dart

import 'package:cached_network_image/cached_network_image.dart'; // CachedNetworkImage
import 'package:flutter/material.dart';              // StatelessWidget, Widget, etc.
import 'package:flutter_bloc/flutter_bloc.dart';     // BlocBuilder, context.read<>()
import 'package:go_router/go_router.dart';           // context.push(), context.go()
import 'package:timeago/timeago.dart' as timeago;   // timeago.format()

// Presentation - BLoC - Downloads
import '../../bloc/downloads/downloads_bloc.dart';
import '../../bloc/downloads/downloads_state.dart';  // DownloadsLoading, DownloadsLoaded
import '../../bloc/downloads/downloads_event.dart';  // DeleteDownload, DeleteAllDownloads, CancelDownload

// Domain - Models
import '../../../domain/models/downloaded_book.dart'; // DownloadedBook
import '../../../domain/models/download_progress.dart'; // DownloadProgress

// Core - Theme
import '../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Downloads',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              if (value == 'delete_all') {
                _showDeleteAllDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete_all',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_sweep,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text('Delete All Downloads'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<DownloadsBloc, DownloadsState>(
        builder: (context, state) {
          // ── Loading ───────────────────────
          if (state is DownloadsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ── Loaded ────────────────────────
          if (state is DownloadsLoaded) {
            if (state.downloads.isEmpty) {
              return _buildEmptyState(context);
            }

            return Column(
              children: [
                // Storage Info Bar
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary
                        .withOpacity(0.08),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${state.downloads.length} books',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.totalSize,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Active Downloads
                if (state.activeDownloads
                    .isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets
                        .symmetric(horizontal: 20),
                    child: Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        'Downloading',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...state.activeDownloads.map(
                    (download) => _ActiveDownloadTile(
                      download: download,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Downloaded Books List
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    physics:
                        const BouncingScrollPhysics(),
                    itemCount:
                        state.downloads.length,
                    itemBuilder: (context, index) {
                      final book =
                          state.downloads[index];
                      return _DownloadedBookTile(
                        book: book,
                        onDelete: () {
                          context
                              .read<DownloadsBloc>()
                              .add(
                                DeleteDownload(
                                  bookId: book.bookId,
                                ),
                              );
                        },
                        onTap: () => context.push(
                          '/reader/${book.bookId}',
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          // ── Error ─────────────────────────
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // EMPTY STATE
  // ─────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.download_for_offline_rounded,
                size: 56,
                color: Colors.blue.shade300,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'No Downloads Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Download books to read them offline.\n'
              'Tap the download icon on any book.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            ElevatedButton.icon(
              onPressed: () =>
                  context.go('/explore'),
              icon: const Icon(Icons.explore),
              label: const Text('Explore Books'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────

  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title:
            const Text('Delete All Downloads?'),
        content: const Text(
          'This will remove all downloaded books'
          ' from your device. Your reading progress'
          ' will be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<DownloadsBloc>()
                  .add(DeleteAllDownloads());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _ActiveDownloadTile
// ─────────────────────────────────────────────────────────────────────────────

class _ActiveDownloadTile extends StatelessWidget {
  final DownloadProgress download;

  const _ActiveDownloadTile({
    required this.download,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          // Circular Progress with % label
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: download.progress,
                  strokeWidth: 3,
                  backgroundColor:
                      Colors.blue.shade100,
                  valueColor:
                      AlwaysStoppedAnimation(
                    Colors.blue.shade600,
                  ),
                ),
                Text(
                  '${(download.progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Label + Progress Bar
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Downloading...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: download.progress,
                    backgroundColor:
                        Colors.blue.shade100,
                    valueColor:
                        AlwaysStoppedAnimation(
                      Colors.blue.shade500,
                    ),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Cancel Button
          IconButton(
            icon:
                const Icon(Icons.close, size: 20),
            onPressed: () {
              context
                  .read<DownloadsBloc>()
                  .add(
                    CancelDownload(
                      bookId: download.bookId,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _DownloadedBookTile
// ─────────────────────────────────────────────────────────────────────────────

class _DownloadedBookTile extends StatelessWidget {
  final DownloadedBook book;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _DownloadedBookTile({
    required this.book,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(book.bookId),
      direction: DismissDirection.endToStart,

      // Swipe Background
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      // Confirm Dialog
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),
            title:
                const Text('Delete Download?'),
            content: Text(
              'Remove "${book.title}" from downloads?'
              ' You can download it again later.',
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },

      onDismissed: (_) => onDelete(),

      // Card Content
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin:
              const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Cover Image
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: book.coverUrl,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      Container(
                    width: 50,
                    height: 70,
                    color: Colors.grey.shade200,
                    child:
                        const Icon(Icons.book),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Book Details
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.storage_rounded,
                          size: 14,
                          color:
                              Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          book.formattedSize,
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons
                              .access_time_rounded,
                          size: 14,
                          color:
                              Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeago.format(
                            book.downloadedAt,
                          ),
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Offline Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.offline_pin_rounded,
                      size: 14,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Offline',
                      style: TextStyle(
                        color:
                            Colors.green.shade600,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}