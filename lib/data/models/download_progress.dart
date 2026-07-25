// lib/data/models/download_progress.dart

import '../enums/download_status.dart';     // DownloadStatus

class DownloadProgress {
  final String bookId;
  final double progress;
  final DownloadStatus status;

  const DownloadProgress({
    required this.bookId,
    required this.progress,
    required this.status,
  });
}