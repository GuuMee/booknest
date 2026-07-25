// lib/presentation/bloc/reader/reader_bloc.dart

import 'package:equatable/equatable.dart';                          // Equatable
import 'package:flutter/foundation.dart';                           // debugPrint
import 'package:flutter_bloc/flutter_bloc.dart';                    // Bloc, Emitter

// Data - Models
import '../../../data/models/reading_progress_model.dart';          // ReadingProgressModel
import '../../../data/models/bookmark_model.dart';                  // BookmarkModel
import '../../../data/models/annotation_model.dart';                // AnnotationModel
import '../../../data/models/app_settings_model.dart';              // AppSettingsModel

// Domain - Repositories
import '../../../domain/repositories/book_repository.dart';         // BookRepository
import '../../../domain/repositories/settings_repository.dart';     // SettingsRepository

// Core - Network
import '../../../core/network/network_info.dart';                   // NetworkInfo

// Services
import '../../../services/download_service.dart';                   // DownloadService

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();

  @override
  List<Object?> get props => [];
}

// ──────────────────────────────────────
class InitReader extends ReaderEvent {
  final String bookId;

  const InitReader({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

// ──────────────────────────────────────
class NavigateToChapter extends ReaderEvent {       // ← ДОБАВЛЕНО
  final int index;

  const NavigateToChapter({required this.index});

  @override
  List<Object?> get props => [index];
}

// ──────────────────────────────────────
class JumpToPage extends ReaderEvent {              // ← ДОБАВЛЕНО
  final int page;

  const JumpToPage({required this.page});

  @override
  List<Object?> get props => [page];
}

// ──────────────────────────────────────
class SaveReadingProgress extends ReaderEvent {
  final String bookId;
  final int currentPage;
  final int totalPages;
  final int secondsRead;

  const SaveReadingProgress({
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    required this.secondsRead,
  });

  @override
  List<Object?> get props => [
        bookId,
        currentPage,
        totalPages,
        secondsRead,
      ];
}

// ──────────────────────────────────────
class AddBookmark extends ReaderEvent {
  final String bookId;
  final BookmarkModel bookmark;

  const AddBookmark({
    required this.bookId,
    required this.bookmark,
  });

  @override
  List<Object?> get props => [bookId, bookmark];
}

// ──────────────────────────────────────
class RemoveBookmark extends ReaderEvent {
  final String bookmarkId;

  const RemoveBookmark({required this.bookmarkId});

  @override
  List<Object?> get props => [bookmarkId];
}

// ──────────────────────────────────────
class AddAnnotation extends ReaderEvent {
  final String bookId;
  final AnnotationModel annotation;

  const AddAnnotation({
    required this.bookId,
    required this.annotation,
  });

  @override
  List<Object?> get props => [bookId, annotation];
}

// ──────────────────────────────────────
class UpdateReaderSettings extends ReaderEvent {    // ← ДОБАВЛЕНО
  final AppSettingsModel settings;

  const UpdateReaderSettings({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// ──────────────────────────────────────
class MarkBookComplete extends ReaderEvent {
  final String bookId;

  const MarkBookComplete({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class ReaderState extends Equatable {
  const ReaderState();

  @override
  List<Object?> get props => [];
}

// ──────────────────────────────────────
class ReaderInitial extends ReaderState {}

// ──────────────────────────────────────
class ReaderLoading extends ReaderState {}

// ──────────────────────────────────────
class ReaderReady extends ReaderState {
  final String bookId;
  final String? localPdfPath;
  final ReadingProgressModel? progress;
  final List<BookmarkModel> bookmarks;
  final List<AnnotationModel> annotations;
  final AppSettingsModel? settings;              // ← ДОБАВЛЕНО
  final int currentChapter;                     // ← ДОБАВЛЕНО
  final int currentPage;                        // ← ДОБАВЛЕНО

  const ReaderReady({
    required this.bookId,
    this.localPdfPath,
    this.progress,
    required this.bookmarks,
    required this.annotations,
    this.settings,                              // ← ДОБАВЛЕНО
    this.currentChapter = 0,                   // ← ДОБАВЛЕНО
    this.currentPage = 0,                      // ← ДОБАВЛЕНО
  });

  ReaderReady copyWith({
    String? bookId,
    String? localPdfPath,
    ReadingProgressModel? progress,
    List<BookmarkModel>? bookmarks,
    List<AnnotationModel>? annotations,
    AppSettingsModel? settings,                 // ← ДОБАВЛЕНО
    int? currentChapter,                       // ← ДОБАВЛЕНО
    int? currentPage,                          // ← ДОБАВЛЕНО
  }) {
    return ReaderReady(
      bookId: bookId ?? this.bookId,
      localPdfPath: localPdfPath ?? this.localPdfPath,
      progress: progress ?? this.progress,
      bookmarks: bookmarks ?? this.bookmarks,
      annotations: annotations ?? this.annotations,
      settings: settings ?? this.settings,     // ← ДОБАВЛЕНО
      currentChapter:                          // ← ДОБАВЛЕНО
          currentChapter ?? this.currentChapter,
      currentPage:                             // ← ДОБАВЛЕНО
          currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        bookId,
        localPdfPath,
        progress,
        bookmarks,
        annotations,
        settings,                              // ← ДОБАВЛЕНО
        currentChapter,                        // ← ДОБАВЛЕНО
        currentPage,                           // ← ДОБАВЛЕНО
      ];
}

// ──────────────────────────────────────
class ReaderError extends ReaderState {
  final String message;

  const ReaderError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ──────────────────────────────────────
class BookCompleted extends ReaderState {
  final BookCompletionStats stats;

  const BookCompleted({required this.stats});

  @override
  List<Object?> get props => [stats];
}

// ─────────────────────────────────────────────────────────────────────────────
// VALUE OBJECT — BookCompletionStats
// ─────────────────────────────────────────────────────────────────────────────

class BookCompletionStats {
  final String bookId;
  final int totalSecondsRead;
  final int totalPages;
  final int bookmarksCount;
  final int annotationsCount;
  final DateTime startedAt;
  final DateTime completedAt;

  const BookCompletionStats({
    required this.bookId,
    required this.totalSecondsRead,
    required this.totalPages,
    required this.bookmarksCount,
    required this.annotationsCount,
    required this.startedAt,
    required this.completedAt,
  });

  /// e.g. "2h 15m" or "45m"
  String get formattedReadTime {
    final hours = totalSecondsRead ~/ 3600;
    final minutes = (totalSecondsRead % 3600) ~/ 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  /// Number of calendar days from start to finish
  int get daysToComplete =>
      completedAt.difference(startedAt).inDays + 1;
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  final BookRepository bookRepository;
  final DownloadService downloadService;
  final NetworkInfo networkInfo;
  final SettingsRepository settingsRepository;    // ← ДОБАВЛЕНО

  ReaderBloc({
    required this.bookRepository,
    required this.downloadService,
    required this.networkInfo,
    required this.settingsRepository,             // ← ДОБАВЛЕНО
  }) : super(ReaderInitial()) {
    on<InitReader>(_onInitReader);
    on<NavigateToChapter>(_onNavigateToChapter);  // ← ДОБАВЛЕНО
    on<JumpToPage>(_onJumpToPage);                // ← ДОБАВЛЕНО
    on<SaveReadingProgress>(_onSaveProgress);
    on<AddBookmark>(_onAddBookmark);
    on<RemoveBookmark>(_onRemoveBookmark);
    on<AddAnnotation>(_onAddAnnotation);
    on<UpdateReaderSettings>(_onUpdateSettings);  // ← ДОБАВЛЕНО
    on<MarkBookComplete>(_onMarkComplete);
  }

  // ─────────────────────────────────────────
  // INIT
  // ─────────────────────────────────────────

  Future<void> _onInitReader(
    InitReader event,
    Emitter<ReaderState> emit,
  ) async {
    emit(ReaderLoading());
    try {
      final results = await Future.wait([
        downloadService.getLocalPath(event.bookId),
        bookRepository.getReadingProgress(event.bookId),
        bookRepository.getBookmarks(event.bookId),
        bookRepository.getAnnotations(event.bookId),
        settingsRepository.getSettings(),         // ← ДОБАВЛЕНО
      ]);

      emit(ReaderReady(
        bookId: event.bookId,
        localPdfPath: results[0] as String?,
        progress: results[1] as ReadingProgressModel?,
        bookmarks: results[2] as List<BookmarkModel>,
        annotations: results[3] as List<AnnotationModel>,
        settings: results[4] as AppSettingsModel?, // ← ДОБАВЛЕНО
        currentChapter:                            // ← ДОБАВЛЕНО
            (results[1] as ReadingProgressModel?)
                ?.currentChapter ?? 0,
        currentPage:                               // ← ДОБАВЛЕНО
            (results[1] as ReadingProgressModel?)
                ?.currentPage ?? 0,
      ));
    } catch (e) {
      emit(ReaderError(message: e.toString()));
    }
  }

  // ─────────────────────────────────────────
  // NAVIGATE TO CHAPTER                       // ← ДОБАВЛЕНО
  // ─────────────────────────────────────────

  Future<void> _onNavigateToChapter(
    NavigateToChapter event,
    Emitter<ReaderState> emit,
  ) async {
    if (state is! ReaderReady) return;
    final current = state as ReaderReady;
    emit(current.copyWith(currentChapter: event.index));
  }

  // ─────────────────────────────────────────
  // JUMP TO PAGE                              // ← ДОБАВЛЕНО
  // ─────────────────────────────────────────

  Future<void> _onJumpToPage(
    JumpToPage event,
    Emitter<ReaderState> emit,
  ) async {
    if (state is! ReaderReady) return;
    final current = state as ReaderReady;
    emit(current.copyWith(currentPage: event.page));
  }

  // ─────────────────────────────────────────
  // SAVE PROGRESS
  // ─────────────────────────────────────────

  Future<void> _onSaveProgress(
    SaveReadingProgress event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      final progressPercent =
          (event.currentPage / event.totalPages) * 100;

      // 98% threshold allows for slight margin
      final isCompleted = progressPercent >= 98;

      final progress = ReadingProgressModel(
        bookId: event.bookId,
        currentPage: event.currentPage,
        totalPages: event.totalPages,
        progressPercent: progressPercent,
        totalSecondsRead: event.secondsRead,
        lastReadAt: DateTime.now(),
        startedAt: (state is ReaderReady)
            ? ((state as ReaderReady)
                    .progress
                    ?.startedAt ??
                DateTime.now())
            : DateTime.now(),
        isCompleted: isCompleted,
        completedAt: isCompleted ? DateTime.now() : null,
      );

      await bookRepository.saveReadingProgress(progress);

      if (state is ReaderReady) {
        emit(
          (state as ReaderReady).copyWith(
            progress: progress,
            currentPage: event.currentPage,       // ← ДОБАВЛЕНО
          ),
        );
      }

      // Auto-complete detection
      final alreadyCompleted = state is ReaderReady &&
          (state as ReaderReady)
                  .progress
                  ?.isCompleted ==
              true;

      if (isCompleted && !alreadyCompleted) {
        add(MarkBookComplete(bookId: event.bookId));
      }
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }

  // ─────────────────────────────────────────
  // BOOKMARKS
  // ─────────────────────────────────────────

  Future<void> _onAddBookmark(
    AddBookmark event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      await bookRepository.addBookmark(
        event.bookId,
        event.bookmark,
      );

      if (state is ReaderReady) {
        final current = state as ReaderReady;
        final updatedBookmarks = [
          ...current.bookmarks,
          event.bookmark,
        ]..sort(
            (a, b) =>
                a.pageNumber.compareTo(b.pageNumber),
          );
        emit(current.copyWith(bookmarks: updatedBookmarks));
      }
    } catch (e) {
      debugPrint('Error adding bookmark: $e');
    }
  }

  Future<void> _onRemoveBookmark(
    RemoveBookmark event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      await bookRepository.removeBookmark(event.bookmarkId);

      if (state is ReaderReady) {
        final current = state as ReaderReady;
        final updatedBookmarks = current.bookmarks
            .where((b) => b.id != event.bookmarkId)
            .toList();
        emit(current.copyWith(bookmarks: updatedBookmarks));
      }
    } catch (e) {
      debugPrint('Error removing bookmark: $e');
    }
  }

  // ─────────────────────────────────────────
  // ANNOTATIONS
  // ─────────────────────────────────────────

  Future<void> _onAddAnnotation(
    AddAnnotation event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      await bookRepository.addAnnotation(
        event.bookId,
        event.annotation,
      );

      if (state is ReaderReady) {
        final current = state as ReaderReady;
        final updatedAnnotations = [
          ...current.annotations,
          event.annotation,
        ];
        emit(current.copyWith(annotations: updatedAnnotations));
      }
    } catch (e) {
      debugPrint('Error adding annotation: $e');
    }
  }

  // ─────────────────────────────────────────
  // UPDATE SETTINGS                           // ← ДОБАВЛЕНО
  // ─────────────────────────────────────────

  Future<void> _onUpdateSettings(
    UpdateReaderSettings event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      await settingsRepository.saveSettings(event.settings);

      if (state is ReaderReady) {
        emit(
          (state as ReaderReady)
              .copyWith(settings: event.settings),
        );
      }
    } catch (e) {
      debugPrint('Error updating settings: $e');
    }
  }

  // ─────────────────────────────────────────
  // MARK COMPLETE
  // ─────────────────────────────────────────

  Future<void> _onMarkComplete(
    MarkBookComplete event,
    Emitter<ReaderState> emit,
  ) async {
    try {
      await bookRepository.markComplete(event.bookId);

      if (state is ReaderReady) {
        final current = state as ReaderReady;
        emit(
          BookCompleted(
            stats: BookCompletionStats(
              bookId: event.bookId,
              totalSecondsRead:
                  current.progress?.totalSecondsRead ?? 0,
              totalPages:
                  current.progress?.totalPages ?? 0,
              bookmarksCount: current.bookmarks.length,
              annotationsCount: current.annotations.length,
              startedAt:
                  current.progress?.startedAt ?? DateTime.now(),
              completedAt: DateTime.now(),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error marking complete: $e');
    }
  }
}