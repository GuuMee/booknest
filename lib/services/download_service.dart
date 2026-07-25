// lib/services/download_service.dart

import 'dart:async';                                  // StreamController
                                                      // Stream

import 'dart:io';                                     // File

import 'package:dio/dio.dart';                        // Dio
                                                      // CancelToken
                                                      // DioException
                                                      // DioExceptionType

import 'package:get_it/get_it.dart';                  // GetIt
                                                      // .I<T>()

import 'package:hive/hive.dart';                      // Hive
                                                      // .box()
                                                      // Box

import 'package:path_provider/path_provider.dart';    // getApplicationDocumentsDirectory()

// Services
import 'notification_service.dart';                   // NotificationService
                                                      // .showDownloadComplete()

// Data - Models
import '../data/models/downloaded_book.dart';         // DownloadedBook
                                                      // .toJson()
                                                      // .fromJson()

// Data - Models
import '../data/models/download_progress.dart';       // DownloadProgress
                                                      // .bookId
                                                      // .progress
                                                      // .status

// Data - Enums
import '../data/enums/download_status.dart';          // DownloadStatus

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class DownloadService {
  final Dio _dio;
  final Box _downloadsBox;

  // CancelToken из новой версии
  final Map<String, CancelToken> _activeDownloads =
      {};

  final StreamController<DownloadProgress>
      _progressController =
          StreamController<DownloadProgress>.broadcast();

  Stream<DownloadProgress> get progressStream =>
      _progressController.stream;

  DownloadService({
    required Dio dio,
    required Box downloadsBox,
  })  : _dio = dio,
        _downloadsBox = downloadsBox;

  // ─────────────────────────────────────────
  // DOWNLOAD
  // ─────────────────────────────────────────

  // 🆕 Расширен: onComplete, onError callbacks
  //    нужны DownloadsBloc._onStartDownload()
  Future<String> downloadBook({
    required String bookId,
    required String downloadUrl,
    required String title,
    required String coverUrl,
    Function(double progress)? onProgress,
    Function(String filePath)? onComplete,   // 🆕
    Function(String error)? onError,         // 🆕
  }) async {
    if (_activeDownloads.containsKey(bookId)) {
      throw Exception(
        'Download already in progress',
      );
    }

    final cancelToken = CancelToken();
    _activeDownloads[bookId] = cancelToken;

    try {
      final dir =
          await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/books/$bookId.pdf';
      final file = File(filePath);
      await file.parent.create(recursive: true);

      _progressController.add(
        DownloadProgress(
          bookId: bookId,
          progress: 0,
          status: DownloadStatus.downloading,
        ),
      );

      await _dio.download(
        downloadUrl,
        filePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress?.call(progress);
            _progressController.add(
              DownloadProgress(
                bookId: bookId,
                progress: progress,
                status: DownloadStatus.downloading,
              ),
            );
          }
        },
      );

      // Save download record
      final fileSize = await file.length();
      final downloadRecord = DownloadedBook(
        bookId: bookId,
        title: title,
        coverUrl: coverUrl,
        filePath: filePath,
        fileSize: fileSize,
        downloadedAt: DateTime.now(),
      );
      await _downloadsBox.put(
        bookId,
        downloadRecord.toJson(),
      );

      _progressController.add(
        DownloadProgress(
          bookId: bookId,
          progress: 1.0,
          status: DownloadStatus.completed,
        ),
      );

      _activeDownloads.remove(bookId);

      // Show notification
      await GetIt.I<NotificationService>()
          .showDownloadComplete(title);

      // 🆕 onComplete callback для Bloc
      onComplete?.call(filePath);

      return filePath;
    } on DioException catch (e) {
      _activeDownloads.remove(bookId);

      if (e.type == DioExceptionType.cancel) {
        _progressController.add(
          DownloadProgress(
            bookId: bookId,
            progress: 0,
            status: DownloadStatus.cancelled,
          ),
        );

        final file = File(
          '${(await getApplicationDocumentsDirectory()).path}'
          '/books/$bookId.pdf',
        );
        if (await file.exists()) {
          await file.delete();
        }
        throw Exception('Download cancelled');
      }

      _progressController.add(
        DownloadProgress(
          bookId: bookId,
          progress: 0,
          status: DownloadStatus.failed,
        ),
      );

      // 🆕 onError callback для Bloc
      onError?.call(e.message ?? 'Unknown error');

      throw Exception(
        'Download failed: ${e.message}',
      );
    }
  }

  // ─────────────────────────────────────────
  // CANCEL
  // ─────────────────────────────────────────

  void cancelDownload(String bookId) {
    final cancelToken = _activeDownloads[bookId];
    if (cancelToken != null &&
        !cancelToken.isCancelled) {
      cancelToken.cancel(
        'User cancelled download',
      );
    }
    _activeDownloads.remove(bookId);
  }

  // ─────────────────────────────────────────
  // DELETE
  // ─────────────────────────────────────────

  Future<void> deleteDownload(
    String bookId,
  ) async {
    final record = _downloadsBox.get(bookId);
    if (record != null) {
      final data =
          Map<String, dynamic>.from(record);
      final filePath = data['filePath'] as String;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      await _downloadsBox.delete(bookId);
    }
  }

  Future<void> deleteAllDownloads() async {
    final keys = _downloadsBox.keys.toList();
    for (final key in keys) {
      await deleteDownload(key as String);
    }
  }

  // ─────────────────────────────────────────
  // QUERIES
  // ─────────────────────────────────────────

  // sync — только проверка Hive
  bool isDownloaded(String bookId) {
    return _downloadsBox.containsKey(bookId);
  }

  // 🆕 нужен DownloadsBloc._onStartDownload()
  bool isDownloading(String bookId) {
    return _activeDownloads.containsKey(bookId);
  }

  String? getLocalPath(String bookId) {
    final record = _downloadsBox.get(bookId);
    if (record != null) {
      final data =
          Map<String, dynamic>.from(record);
      return data['filePath'] as String;
    }
    return null;
  }

  // ─────────────────────────────────────────
  // LIST
  // ─────────────────────────────────────────

  // sync — используется в _emitCurrentState()
  List<DownloadedBook> getAllDownloads() {
    return _downloadsBox.keys.map((key) {
      final data = Map<String, dynamic>.from(
        _downloadsBox.get(key),
      );
      return DownloadedBook.fromJson(data);
    }).toList()
      ..sort(
        (a, b) => b.downloadedAt.compareTo(
          a.downloadedAt,
        ),
      );
  }

  // 🆕 async версия со stale cleanup
  //    из старой версии — чистит записи
  //    у которых файл уже удалён
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
          DownloadedBook.fromJson(data),
        );
      } else {
        // Clean up stale entry
        await _downloadsBox.delete(key);
      }
    }

    return downloads
      ..sort(
        (a, b) => b.downloadedAt.compareTo(
          a.downloadedAt,
        ),
      );
  }

  // ─────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────

  // 🆕 нужен DownloadsBloc._onLoadDownloads()
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

  // 🆕 из старой версии
  void dispose() {
    _progressController.close();
  }
}