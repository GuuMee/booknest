// lib/data/models/reading_progress_model.dart

class ReadingProgressModel {
  final String id;
  final String userId;
  final String bookId;
  final int currentPage;
  final int totalPages;
  final double progressPercent;
  final int totalSecondsRead;
  final List<BookmarkModel> bookmarks;
  final List<AnnotationModel> annotations;
  final DateTime lastReadAt;
  final DateTime startedAt;
  final DateTime? completedAt;
  final bool isCompleted;

  ReadingProgressModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    required this.progressPercent,
    this.totalSecondsRead = 0,
    this.bookmarks = const [],
    this.annotations = const [],
    required this.lastReadAt,
    required this.startedAt,
    this.completedAt,
    this.isCompleted = false,
  });

  factory ReadingProgressModel.fromJson(Map<String, dynamic> json) {
    return ReadingProgressModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      bookId: json['bookId'] ?? '',
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      progressPercent: (json['progressPercent'] ?? 0.0).toDouble(),
      totalSecondsRead: json['totalSecondsRead'] ?? 0,
      bookmarks: (json['bookmarks'] as List<dynamic>?)
              ?.map((e) => BookmarkModel.fromJson(e))
              .toList() ??
          [],
      annotations: (json['annotations'] as List<dynamic>?)
              ?.map((e) => AnnotationModel.fromJson(e))
              .toList() ??
          [],
      lastReadAt: DateTime.parse(json['lastReadAt']),
      startedAt: DateTime.parse(json['startedAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'currentPage': currentPage,
      'totalPages': totalPages,
      'progressPercent': progressPercent,
      'totalSecondsRead': totalSecondsRead,
      'bookmarks': bookmarks.map((e) => e.toJson()).toList(),
      'annotations': annotations.map((e) => e.toJson()).toList(),
      'lastReadAt': lastReadAt.toIso8601String(),
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  int get pagesRemaining => totalPages - currentPage;
  String get readingTime {
    final hours = totalSecondsRead ~/ 3600;
    final minutes = (totalSecondsRead % 3600) ~/ 60;
    return hours > 0 ? '${hours}ч ${minutes}м' : '${minutes}м';
  }
}

class BookmarkModel {
  final String id;
  final int pageNumber;
  final String? title;
  final String? note;
  final DateTime createdAt;

  BookmarkModel({
    required this.id,
    required this.pageNumber,
    this.title,
    this.note,
    required this.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] ?? '',
      pageNumber: json['pageNumber'] ?? 0,
      title: json['title'],
      note: json['note'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageNumber': pageNumber,
      'title': title,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class AnnotationModel {
  final String id;
  final int pageNumber;
  final String type;
  final String? color;
  final String? text;
  final String? note;
  final Map<String, dynamic> position;
  final DateTime createdAt;

  AnnotationModel({
    required this.id,
    required this.pageNumber,
    required this.type,
    this.color,
    this.text,
    this.note,
    required this.position,
    required this.createdAt,
  });

  factory AnnotationModel.fromJson(Map<String, dynamic> json) {
    return AnnotationModel(
      id: json['id'] ?? '',
      pageNumber: json['pageNumber'] ?? 0,
      type: json['type'] ?? 'highlight',
      color: json['color'],
      text: json['text'],
      note: json['note'],
      position: Map<String, dynamic>.from(json['position'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageNumber': pageNumber,
      'type': type,
      'color': color,
      'text': text,
      'note': note,
      'position': position,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool get isHighlight => type == 'highlight';
  bool get isUnderline => type == 'underline';
  bool get isNote => type == 'note';
}