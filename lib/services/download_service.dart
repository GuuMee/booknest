// lib/services/download_service.dart

import 'dart:async';                              // StreamController, Stream
import 'dart:io';                                 // File, Directory

import 'package:dio/dio.dart';                    // Dio
import 'package:hive/hive.dart';                  // Box
import 'package:path_provider/path_provider.dart'; // getApplicationDocumentsDirectory

// Data - Models
import '../data/models/book_model.dart';          // BookModel

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class DownloadService {
  final Dio _dio;
  final Box _downloadsBox;

  final StreamController<DownloadProgress>
      _progressController =
          StreamController<DownloadProgress>.broadcast();

  DownloadService({
    required Dio dio,
    required Box downloadsBox,
  })  : _dio = dio,
        _downloadsBox = downloadsBox;

  // ─────────────────────────────────────────
  // STREAM
  // ─────────────────────────────────────────

  Stream<DownloadProgress> get downloadProgress =>
      _progressController.stream;

  // ─────────────────────────────────────────
  // DOWNLOAD
  // ─────────────────────────────────────────

  Future<String> downloadBook(BookModel book) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/books/${book.id}.pdf';
    final file = File(filePath);

    // Create directory if it doesn't exist
    await file.parent.create(recursive: true);

    try {
      await _dio.download(
        book.pdfUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;
            _progressController.add(
              DownloadProgress(
                bookId: book.id,
                progress: progress,
                receivedBytes: received,
                totalBytes: total,
              ),
            );
          }
        },
      );

      // Save download metadata to Hive
      await _downloadsBox.put(book.id, {
        'bookId': book.id,
        'filePath': filePath,
        'downloadedAt':
            DateTime.now().toIso8601String(),
        'fileSize': await file.length(),
        'title': book.title,
        'coverUrl': book.coverImageUrl,
      });

      _progressController.add(
        DownloadProgress(
          bookId: book.id,
          progress: 1.0,
          receivedBytes: await file.length(),
          totalBytes: await file.length(),
          isComplete: true,
        ),
      );

      return filePath;
    } catch (e) {
      // Clean up partial download
      if (await file.exists()) {
        await file.delete();
      }

      _progressController.add(
        DownloadProgress(
          bookId: book.id,
          progress: 0,
          receivedBytes: 0,
          totalBytes: 0,
          error: e.toString(),
        ),
      );

      rethrow;
    }
  }

  // ─────────────────────────────────────────
  // QUERIES
  // ─────────────────────────────────────────

  Future<bool> isDownloaded(String bookId) async {
    final data = _downloadsBox.get(bookId);
    if (data == null) return false;

    final filePath = data['filePath'] as String;
    return File(filePath).exists();
  }

  Future<String?> getLocalPath(String bookId) async {
    final data = _downloadsBox.get(bookId);
    if (data == null) return null;

    final filePath = data['filePath'] as String;
    if (await File(filePath).exists()) {
      return filePath;
    }
    return null;
  }

  // ─────────────────────────────────────────
  // DELETE
  // ─────────────────────────────────────────

  Future<void> deleteDownload(String bookId) async {
    final data = _downloadsBox.get(bookId);
    if (data != null) {
      final filePath = data['filePath'] as String;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      await _downloadsBox.delete(bookId);
    }
  }

  Future<void> deleteAllDownloads() async {
    for (final key in _downloadsBox.keys) {
      await deleteDownload(key as String);
    }
  }

  // ─────────────────────────────────────────
  // LIST
  // ─────────────────────────────────────────

  Future<List<DownloadedBook>>
      getDownloadedBooks() async {
    final downloads = <DownloadedBook>[];

    for (final key in _downloadsBox.keys) {
      final data = Map<String, dynamic>.from(
        _downloadsBox.get(key),
      );
      final filePath = data['filePath'] as String;

      if (await File(filePath).exists()) {
        downloads.add(
          DownloadedBook(
            bookId: data['bookId'] as String,
            filePath: filePath,
            downloadedAt: DateTime.parse(
              data['downloadedAt'] as String,
            ),
            fileSize: data['fileSize'] as int,
            title: data['title'] as String,
            coverUrl: data['coverUrl'] as String,
          ),
        );
      } else {
        // Clean up stale entry
        await _downloadsBox.delete(key);
      }
    }

    // Newest first
    return downloads
      ..sort(
        (a, b) =>
            b.downloadedAt.compareTo(a.downloadedAt),
      );
  }

  // ─────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────

  Future<int> getTotalDownloadSize() async {
    int total = 0;
    for (final key in _downloadsBox.keys) {
      final data = _downloadsBox.get(key);
      if (data != null) {
        total += (data['fileSize'] as int?) ?? 0;
      }
    }
    return total;
  }

  // ─────────────────────────────────────────
  // DISPOSE
  // ─────────────────────────────────────────

  void dispose() {
    _progressController.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VALUE OBJECT — DownloadProgress
// ─────────────────────────────────────────────────────────────────────────────

class DownloadProgress {
  final String bookId;
  final double progress;
  final int receivedBytes;
  final int totalBytes;
  final bool isComplete;
  final String? error;

  const DownloadProgress({
    required this.bookId,
    required this.progress,
    required this.receivedBytes,
    required this.totalBytes,
    this.isComplete = false,
    this.error,
  });

  /// e.g. "47%"
  String get formattedProgress =>
      '${(progress * 100).toInt()}%';

  /// e.g. "12.3 MB"
  String get formattedSize {
    final mb = totalBytes / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VALUE OBJECT — DownloadedBook
// ─────────────────────────────────────────────────────────────────────────────

class DownloadedBook {
  final String bookId;
  final String filePath;
  final DateTime downloadedAt;
  final int fileSize;
  final String title;
  final String coverUrl;

  const DownloadedBook({
    required this.bookId,
    required this.filePath,
    required this.downloadedAt,
    required this.fileSize,
    required this.title,
    required this.coverUrl,
  });

  /// e.g. "8.5 MB"
  String get formattedSize {
    final mb = fileSize / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }
}