// lib/presentation/blocs/downloads/downloads_bloc.dart

import 'package:equatable/equatable.dart';          // Equatable
                                                    // .props

import 'package:flutter_bloc/flutter_bloc.dart';    // Bloc
                                                    // Emitter
                                                    // .on<Event>()
                                                    // .add()

// Services
import '../../../services/download_service.dart';   // DownloadService
                                                    // .getAllDownloads()
                                                    // .getTotalDownloadSize()
                                                    // .isDownloaded()
                                                    // .isDownloading()
                                                    // .downloadBook()
                                                    // .cancelDownload()
                                                    // .deleteDownload()
                                                    // .deleteAllDownloads()

import '../../../services/notification_service.dart'; // NotificationService
                                                      // .showDownloadComplete()

// Data - Models
import '../../../data/models/downloaded_book.dart'; // DownloadedBook
                                                    // .bookId
                                                    // .fileSize

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS
// ─────────────────────────────────────────────────────────────────────────────

abstract class DownloadsEvent extends Equatable {
  const DownloadsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDownloads extends DownloadsEvent {}

class StartDownload extends DownloadsEvent {
  final String bookId;
  final String downloadUrl;
  final String title;
  final String coverUrl;

  const StartDownload({
    required this.bookId,
    required this.downloadUrl,
    required this.title,
    required this.coverUrl,
  });

  @override
  List<Object?> get props => [bookId];
}

class CancelDownload extends DownloadsEvent {
  final String bookId;

  const CancelDownload({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class DeleteDownload extends DownloadsEvent {
  final String bookId;

  const DeleteDownload({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class DeleteAllDownloads extends DownloadsEvent {}

class UpdateDownloadProgress extends DownloadsEvent {
  final String bookId;
  final double progress;

  const UpdateDownloadProgress({
    required this.bookId,
    required this.progress,
  });

  @override
  List<Object?> get props => [bookId, progress];
}

class DownloadCompleted extends DownloadsEvent {
  final String bookId;

  const DownloadCompleted({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

abstract class DownloadsState extends Equatable {
  const DownloadsState();

  @override
  List<Object?> get props => [];
}

class DownloadsInitial extends DownloadsState {}

class DownloadsLoading extends DownloadsState {}

class DownloadsLoaded extends DownloadsState {
  final List<DownloadedBook> downloads;
  final List<DownloadProgress> activeDownloads;
  final String totalSize;

  const DownloadsLoaded({
    required this.downloads,
    this.activeDownloads = const [],
    required this.totalSize,
  });

  @override
  List<Object?> get props => [
        downloads,
        activeDownloads,
        totalSize,
      ];
}

class DownloadsError extends DownloadsState {
  final String message;

  const DownloadsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// DOWNLOAD PROGRESS MODEL
// ─────────────────────────────────────────────────────────────────────────────

class DownloadProgress {
  final String bookId;
  final String title;
  final double progress;

  const DownloadProgress({
    required this.bookId,
    required this.title,
    this.progress = 0,
  });

  DownloadProgress copyWith({double? progress}) {
    return DownloadProgress(
      bookId: bookId,
      title: title,
      progress: progress ?? this.progress,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class DownloadsBloc
    extends Bloc<DownloadsEvent, DownloadsState> {
  final DownloadService _downloadService;
  final NotificationService _notificationService;
  final List<DownloadProgress> _activeDownloads = [];

  DownloadsBloc({
    required DownloadService downloadService,
    required NotificationService notificationService,
  })  : _downloadService = downloadService,
        _notificationService = notificationService,
        super(DownloadsInitial()) {
    on<LoadDownloads>(_onLoadDownloads);
    on<StartDownload>(_onStartDownload);
    on<CancelDownload>(_onCancelDownload);
    on<DeleteDownload>(_onDeleteDownload);
    on<DeleteAllDownloads>(_onDeleteAllDownloads);
    on<UpdateDownloadProgress>(_onUpdateProgress);
    on<DownloadCompleted>(_onDownloadCompleted);
  }

  // ─────────────────────────────────────────
  // HANDLERS
  // ─────────────────────────────────────────

  Future<void> _onLoadDownloads(
    LoadDownloads event,
    Emitter<DownloadsState> emit,
  ) async {
    emit(DownloadsLoading());
    try {
      final downloads =
          _downloadService.getAllDownloads();
      final totalSize =
          await _downloadService.getTotalDownloadSize();
      emit(DownloadsLoaded(
        downloads: downloads,
        activeDownloads: _activeDownloads,
        totalSize: _formatBytes(totalSize),
      ));
    } catch (e) {
      emit(DownloadsError(message: e.toString()));
    }
  }

  Future<void> _onStartDownload(
    StartDownload event,
    Emitter<DownloadsState> emit,
  ) async {
    // Already saved
    if (_downloadService.isDownloaded(event.bookId)) {
      return;
    }
    // Already in progress
    if (_downloadService.isDownloading(
      event.bookId,
    )) {
      return;
    }

    // Track progress locally
    _activeDownloads.add(
      DownloadProgress(
        bookId: event.bookId,
        title: event.title,
      ),
    );
    _emitCurrentState(emit);

    // Delegate to service
    await _downloadService.downloadBook(
      bookId: event.bookId,
      downloadUrl: event.downloadUrl,
      title: event.title,
      coverUrl: event.coverUrl,
      onProgress: (progress) {
        add(UpdateDownloadProgress(
          bookId: event.bookId,
          progress: progress,
        ));
      },
      onComplete: (filePath) {
        add(DownloadCompleted(
          bookId: event.bookId,
        ));
      },
      onError: (error) {
        _activeDownloads.removeWhere(
          (d) => d.bookId == event.bookId,
        );
        add(LoadDownloads());
      },
    );
  }

  void _onUpdateProgress(
    UpdateDownloadProgress event,
    Emitter<DownloadsState> emit,
  ) {
    final index = _activeDownloads.indexWhere(
      (d) => d.bookId == event.bookId,
    );
    if (index != -1) {
      _activeDownloads[index] =
          _activeDownloads[index].copyWith(
        progress: event.progress,
      );
      _emitCurrentState(emit);
    }
  }

  Future<void> _onDownloadCompleted(
    DownloadCompleted event,
    Emitter<DownloadsState> emit,
  ) async {
    final download = _activeDownloads.firstWhere(
      (d) => d.bookId == event.bookId,
      orElse: () => DownloadProgress(
        bookId: event.bookId,
        title: '',
      ),
    );

    _activeDownloads.removeWhere(
      (d) => d.bookId == event.bookId,
    );

    await _notificationService
        .showDownloadComplete(download.title);

    add(LoadDownloads());
  }

  Future<void> _onCancelDownload(
    CancelDownload event,
    Emitter<DownloadsState> emit,
  ) async {
    _downloadService.cancelDownload(event.bookId);
    _activeDownloads.removeWhere(
      (d) => d.bookId == event.bookId,
    );
    _emitCurrentState(emit);
  }

  Future<void> _onDeleteDownload(
    DeleteDownload event,
    Emitter<DownloadsState> emit,
  ) async {
    await _downloadService.deleteDownload(
      event.bookId,
    );
    add(LoadDownloads());
  }

  Future<void> _onDeleteAllDownloads(
    DeleteAllDownloads event,
    Emitter<DownloadsState> emit,
  ) async {
    await _downloadService.deleteAllDownloads();
    _activeDownloads.clear();
    add(LoadDownloads());
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  // ✅ Баг исправлен — убрано дублирование объявления
  void _emitCurrentState(
    Emitter<DownloadsState> emit,
  ) {
    final downloads =
        _downloadService.getAllDownloads();
    int totalSize = 0;
    for (final d in downloads) {
      totalSize += d.fileSize;
    }
    emit(DownloadsLoaded(
      downloads: downloads,
      activeDownloads: List.from(_activeDownloads),
      totalSize: _formatBytes(totalSize),
    ));
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}