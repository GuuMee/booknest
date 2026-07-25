// lib/data/models/downloaded_book.dart

// ✅ No imports needed — only Dart built-in types:
//    String, int, bool, DateTime, Map<String, dynamic>

// ─────────────────────────────────────────────────────────────────────────────
// MODEL — DownloadedBook
// ─────────────────────────────────────────────────────────────────────────────

class DownloadedBook {
  final String bookId;
  final String title;
  final String coverUrl;
  final String filePath;
  final int fileSize;
  final DateTime downloadedAt;

  const DownloadedBook({
    required this.bookId,
    required this.title,
    required this.coverUrl,
    required this.filePath,
    required this.fileSize,
    required this.downloadedAt,
  });

  // ─────────────────────────────────────────
  // GETTERS
  // ─────────────────────────────────────────

  String get formattedSize {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    }
    if (fileSize < 1024 * 1024 * 1024) {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(fileSize / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // ─────────────────────────────────────────
  // SERIALIZATION
  // ─────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'title': title,
        'coverUrl': coverUrl,
        'filePath': filePath,
        'fileSize': fileSize,
        'downloadedAt': downloadedAt.toIso8601String(),
      };

  factory DownloadedBook.fromJson(
    Map<String, dynamic> json,
  ) {
    return DownloadedBook(
      bookId: json['bookId'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      filePath: json['filePath'] as String,
      fileSize: json['fileSize'] as int,
      downloadedAt: DateTime.parse(
        json['downloadedAt'] as String,
      ),
    );
  }

  // ─────────────────────────────────────────
  // COPY WITH
  // ─────────────────────────────────────────

  DownloadedBook copyWith({
    String? bookId,
    String? title,
    String? coverUrl,
    String? filePath,
    int? fileSize,
    DateTime? downloadedAt,
  }) {
    return DownloadedBook(
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      downloadedAt: downloadedAt ?? this.downloadedAt,
    );
  }
}