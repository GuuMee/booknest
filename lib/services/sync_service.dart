// lib/services/sync_service.dart

import 'dart:async';

import 'package:flutter/foundation.dart'; // debugPrint

// Data - DataSources
import '../data/datasources/local/book_local_source.dart';
import '../data/datasources/remote/book_remote_source.dart';

// Data - Models
import '../data/models/reading_progress_model.dart';
import '../data/models/bookmark_model.dart';
import '../data/models/annotation_model.dart';

// Services
import 'network_info.dart';

class SyncService {
  final BookLocalDataSource _localDataSource;
  final BookRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  Timer? _syncTimer;

  SyncService({
    required BookLocalDataSource localDataSource,
    required BookRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  /// Start periodic sync (every 5 minutes)
  void startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => syncPendingItems(),
    );

    // Also listen for connectivity changes
    _networkInfo.onConnectionChanged.listen((connected) {
      if (connected) {
        syncPendingItems();
      }
    });
  }

  /// Sync all pending items
  Future<SyncResult> syncPendingItems() async {
    if (!await _networkInfo.isConnected) {
      return SyncResult(synced: 0, failed: 0, pending: 0);
    }

    final pendingItems = await _localDataSource.getPendingSyncItems();
    int synced = 0;
    int failed = 0;

    for (final item in pendingItems) {
      try {
        final type = item['type'] as String;
        final data = Map<String, dynamic>.from(item['data'] as Map);

        switch (type) {
          case 'progress':
            final progress = ReadingProgressModel.fromJson(data);
            await _remoteDataSource.saveProgress(progress);
            break;
          case 'bookmark_add':
            final bookId = data['bookId'] as String;
            final bookmark = BookmarkModel.fromJson(
              Map<String, dynamic>.from(data['bookmark'] as Map),
            );
            await _remoteDataSource.addBookmark(bookId, bookmark);
            break;
          case 'bookmark_remove':
            final bookmarkId = data['bookmarkId'] as String;
            await _remoteDataSource.removeBookmark(bookmarkId);
            break;
          case 'favorite_toggle':
            final bookId = data['bookId'] as String;
            await _remoteDataSource.toggleFavorite(bookId);
            break;
          case 'annotation_add':
            final bookId = data['bookId'] as String;
            final annotation = AnnotationModel.fromJson(
              Map<String, dynamic>.from(data['annotation'] as Map),
            );
            await _remoteDataSource.addAnnotation(bookId, annotation);
            break;
        }

        // Remove from queue on success
        final key =
            '${type}_${DateTime.parse(item['timestamp'] as String).millisecondsSinceEpoch}';
        await _localDataSource.clearSyncItem(key);
        synced++;
      } catch (e) {
        failed++;
        debugPrint('Sync failed for item: $e');
      }
    }

    return SyncResult(
      synced: synced,
      failed: failed,
      pending: pendingItems.length - synced,
    );
  }

  void stopPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  void dispose() {
    stopPeriodicSync();
  }
}

class SyncResult {
  final int synced;
  final int failed;
  final int pending;

  SyncResult({
    required this.synced,
    required this.failed,
    required this.pending,
  });

  bool get isComplete => pending == 0 && failed == 0;
}