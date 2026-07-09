// lib/data/models/book_model.dart

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

//part 'book_model.g.dart';  // для Hive генератора

// ─── Age Group Enum ─────────────────────────────────────
enum AgeGroup {
  toddler,    // 0-3
  kids,       // 3-6
  children,   // 7-12
  teen,       // 13-17
  adult,      // 18+
}

extension AgeGroupExtension on AgeGroup {
  String get label {
    switch (this) {
      case AgeGroup.toddler:  return '0-3';
      case AgeGroup.kids:     return '3-6';
      case AgeGroup.children: return '7-12';
      case AgeGroup.teen:     return '13-17';
      case AgeGroup.adult:    return '18+';
    }
  }

  static AgeGroup fromString(String value) {
    switch (value) {
      case '0-3':  return AgeGroup.toddler;
      case '3-6':  return AgeGroup.kids;
      case '7-12': return AgeGroup.children;
      case '13-17': return AgeGroup.teen;
      case '18+':  return AgeGroup.adult;
      default:     return AgeGroup.adult;
    }
  }
}

// ─── Book Model ─────────────────────────────────────────
@HiveType(typeId: 0)                    // ✅ Hive аннотация
class BookModel extends Equatable {     // ✅ Equatable для BLoC

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String coverImageUrl;

  @HiveField(5)
  final String pdfUrl;

  @HiveField(6)
  final String? localPdfPath;

  @HiveField(7)
  final int pageCount;

  @HiveField(8)
  final double rating;

  @HiveField(9)
  final int ratingCount;

  @HiveField(10)
  final int downloadCount;

  @HiveField(11)
  final List<String> categories;

  @HiveField(12)
  final String language;

  @HiveField(13)
  final String ageGroup;              // ✅ String для Hive/JSON

  @HiveField(14)
  final bool isPremium;

  @HiveField(15)
  final bool isFeatured;

  @HiveField(16)
  final bool isDownloaded;

  @HiveField(17)
  final String isbn;

  @HiveField(18)
  final String publisher;

  @HiveField(19)
  final DateTime publishDate;

  @HiveField(20)
  final DateTime addedDate;

  @HiveField(21)
  final int fileSizeMB;

  @HiveField(22)
  final Map<String, dynamic>? metadata;

  // ─── Computed Properties ──────────────────────────────
  AgeGroup get ageGroupEnum =>        // ✅ enum геттер
      AgeGroupExtension.fromString(ageGroup);

  bool get isAvailableOffline =>      // ✅ удобный геттер
      isDownloaded && localPdfPath != null;

  String get fileSizeLabel =>         // ✅ для UI
      fileSizeMB > 0 ? '$fileSizeMB MB' : 'Unknown';

  String get ratingLabel =>           // ✅ для UI
      rating.toStringAsFixed(1);


  // ─── Constructor ──────────────────────────────────────
  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
    required this.pdfUrl,
    this.localPdfPath,
    required this.pageCount,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.downloadCount = 0,
    required this.categories,
    this.language = 'English',
    required this.ageGroup,
    this.isPremium = false,
    this.isFeatured = false,
    this.isDownloaded = false,
    required this.isbn,
    required this.publisher,
    required this.publishDate,
    required this.addedDate,
    this.fileSizeMB = 0,
    this.metadata,
  });

  // ─── fromJson ─────────────────────────────────────────
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id:             json['id'] as String,
      title:          json['title'] as String,
      author:         json['author'] as String,
      description:    json['description'] as String,
      coverImageUrl:  json['coverImageUrl'] as String,
      pdfUrl:         json['pdfUrl'] as String,
      localPdfPath:   json['localPdfPath'] as String?,
      pageCount:      json['pageCount'] as int? ?? 0,
      rating:         (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount:    json['ratingCount'] as int? ?? 0,
      downloadCount:  json['downloadCount'] as int? ?? 0,
      categories:     List<String>.from(
                        json['categories'] as List? ?? [],
                      ),
      language:       json['language'] as String? ?? 'English',
      ageGroup:       json['ageGroup'] as String? ?? '18+',
      isPremium:      json['isPremium'] as bool? ?? false,
      isFeatured:     json['isFeatured'] as bool? ?? false,
      isDownloaded:   json['isDownloaded'] as bool? ?? false,
      isbn:           json['isbn'] as String? ?? '',
      publisher:      json['publisher'] as String? ?? '',
      publishDate:    DateTime.parse(
                        json['publishDate'] as String? ??
                        DateTime.now().toIso8601String(),
                      ),
      addedDate:      DateTime.parse(
                        json['addedDate'] as String? ??
                        DateTime.now().toIso8601String(),
                      ),
      fileSizeMB:     json['fileSizeMB'] as int? ?? 0,
      metadata:       json['metadata'] as Map<String, dynamic>?,
    );
  }

  // ─── toJson ───────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'id':             id,
      'title':          title,
      'author':         author,
      'description':    description,
      'coverImageUrl':  coverImageUrl,
      'pdfUrl':         pdfUrl,
      'localPdfPath':   localPdfPath,
      'pageCount':      pageCount,
      'rating':         rating,
      'ratingCount':    ratingCount,
      'downloadCount':  downloadCount,
      'categories':     categories,
      'language':       language,
      'ageGroup':       ageGroup,
      'isPremium':      isPremium,
      'isFeatured':     isFeatured,
      'isDownloaded':   isDownloaded,
      'isbn':           isbn,
      'publisher':      publisher,
      'publishDate':    publishDate.toIso8601String(),
      'addedDate':      addedDate.toIso8601String(),
      'fileSizeMB':     fileSizeMB,
      'metadata':       metadata,
    };
  }

  // ─── copyWith ─────────────────────────────────────────
  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImageUrl,
    String? pdfUrl,
    String? localPdfPath,
    int? pageCount,
    double? rating,
    int? ratingCount,
    int? downloadCount,
    List<String>? categories,
    String? language,
    String? ageGroup,
    bool? isPremium,
    bool? isFeatured,
    bool? isDownloaded,
    String? isbn,
    String? publisher,
    DateTime? publishDate,
    DateTime? addedDate,
    int? fileSizeMB,
    Map<String, dynamic>? metadata,
  }) {
    return BookModel(
      id:             id            ?? this.id,
      title:          title         ?? this.title,
      author:         author        ?? this.author,
      description:    description   ?? this.description,
      coverImageUrl:  coverImageUrl ?? this.coverImageUrl,
      pdfUrl:         pdfUrl        ?? this.pdfUrl,
      localPdfPath:   localPdfPath  ?? this.localPdfPath,
      pageCount:      pageCount     ?? this.pageCount,
      rating:         rating        ?? this.rating,
      ratingCount:    ratingCount   ?? this.ratingCount,
      downloadCount:  downloadCount ?? this.downloadCount,
      categories:     categories    ?? this.categories,
      language:       language      ?? this.language,
      ageGroup:       ageGroup      ?? this.ageGroup,
      isPremium:      isPremium     ?? this.isPremium,
      isFeatured:     isFeatured    ?? this.isFeatured,
      isDownloaded:   isDownloaded  ?? this.isDownloaded,
      isbn:           isbn          ?? this.isbn,
      publisher:      publisher     ?? this.publisher,
      publishDate:    publishDate   ?? this.publishDate,
      addedDate:      addedDate     ?? this.addedDate,
      fileSizeMB:     fileSizeMB    ?? this.fileSizeMB,
      metadata:       metadata      ?? this.metadata,
    );
  }

  // ─── Equatable ────────────────────────────────────────
  @override
  List<Object?> get props => [
    id,
    title,
    author,
    description,
    coverImageUrl,
    pdfUrl,
    localPdfPath,
    pageCount,
    rating,
    ratingCount,
    downloadCount,
    categories,
    language,
    ageGroup,
    isPremium,
    isFeatured,
    isDownloaded,
    isbn,
    publisher,
    publishDate,
    addedDate,
    fileSizeMB,
    metadata,
  ];

  // ─── toString ─────────────────────────────────────────
  @override
  String toString() {
    return 'BookModel('
      'id: $id, '
      'title: $title, '
      'author: $author, '
      'isPremium: $isPremium, '
      'isDownloaded: $isDownloaded, '
      'rating: $rating'
    ')';
  }
}