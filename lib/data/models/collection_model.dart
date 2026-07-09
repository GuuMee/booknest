// lib/data/models/collection_model.dart

class CollectionModel {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String? coverImageUrl;
  final List<String> bookIds;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  CollectionModel({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.coverImageUrl,
    this.bookIds = const [],
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      bookIds: List<String>.from(json['bookIds'] ?? []),
      isDefault: json['isDefault'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'bookIds': bookIds,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  int get bookCount => bookIds.length;
  bool get isEmpty => bookIds.isEmpty;
  bool get isNotEmpty => bookIds.isNotEmpty;

  CollectionModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? coverImageUrl,
    List<String>? bookIds,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      bookIds: bookIds ?? this.bookIds,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}