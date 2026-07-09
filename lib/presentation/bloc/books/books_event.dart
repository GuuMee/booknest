// lib/presentation/bloc/books/books_event.dart

import 'package:equatable/equatable.dart';

// Models
import '../../../data/models/book_model.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends BooksEvent {}

class SearchBooks extends BooksEvent {
  final String query;
  final Map<String, dynamic>? filters;

  const SearchBooks({required this.query, this.filters});

  @override
  List<Object?> get props => [query, filters];
}

class LoadBooksByCategory extends BooksEvent {
  final String categoryId;
  final int page;

  const LoadBooksByCategory({
    required this.categoryId,
    this.page = 1,
  });

  @override
  List<Object?> get props => [categoryId, page];
}

class DownloadBook extends BooksEvent {
  final BookModel book;

  const DownloadBook({required this.book});

  @override
  List<Object?> get props => [book];
}

class ToggleFavorite extends BooksEvent {
  final String bookId;

  const ToggleFavorite({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class LoadMoreBooks extends BooksEvent {
  final String section; // trending, recommended, new, free
  final int page;

  const LoadMoreBooks({required this.section, required this.page});

  @override
  List<Object?> get props => [section, page];
}