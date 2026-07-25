// lib/data/repositories/reading_progress_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';    // FirebaseFirestore
                                                          // SetOptions
                                                          // CollectionReference
import 'package:firebase_auth/firebase_auth.dart';        // FirebaseAuth
                                                          // currentUser
                                                          // uid
import 'package:hive/hive.dart';                          // Box<dynamic>
                                                          // .get()
                                                          // .put()
                                                          // .delete()
                                                          // .keys

// Data - Models
import '../models/reading_progress.dart';                 // ReadingProgress
                                                          // .fromJson()
                                                          // .toJson()

// ─────────────────────────────────────────────────────────────────────────────

class ReadingProgressRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Box<dynamic> _localBox;

  ReadingProgressRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required Box<dynamic> localBox,
  })  : _firestore = firestore,
        _auth = auth,
        _localBox = localBox;

  String get _userId => _auth.currentUser?.uid ?? 'anonymous';

  // ===== GET PROGRESS =====

  Future<ReadingProgress?> getProgress(String bookId) async {
    // Try local first
    final localKey = 'progress_$bookId';
    final localData = _localBox.get(localKey);
    if (localData != null) {
      return ReadingProgress.fromJson(
        Map<String, dynamic>.from(localData),
      );
    }

    // Fallback to remote
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('reading_progress')
          .doc(bookId)
          .get();

      if (doc.exists) {
        final progress = ReadingProgress.fromJson(doc.data()!);
        // Cache locally
        await _localBox.put(localKey, progress.toJson());
        return progress;
      }
    } catch (_) {}

    return null;
  }

  // ===== SAVE PROGRESS =====

  Future<void> saveProgress(ReadingProgress progress) async {
    final localKey = 'progress_${progress.bookId}';

    // Save locally
    await _localBox.put(localKey, progress.toJson());

    // Sync to remote
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('reading_progress')
          .doc(progress.bookId)
          .set(progress.toJson(), SetOptions(merge: true));
    } catch (_) {
      // Will sync later
    }
  }

  // ===== GET ALL PROGRESS (for library) =====

  Future<List<ReadingProgress>> getAllProgress() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('reading_progress')
          .orderBy('lastReadAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReadingProgress.fromJson(doc.data()))
          .toList();
    } catch (_) {
      // Fallback to local
      final allProgress = <ReadingProgress>[];
      for (final key in _localBox.keys) {
        if (key.toString().startsWith('progress_')) {
          final data = _localBox.get(key);
          if (data != null) {
            allProgress.add(
              ReadingProgress.fromJson(
                Map<String, dynamic>.from(data),
              ),
            );
          }
        }
      }
      return allProgress;
    }
  }

  // ===== GET CURRENTLY READING =====

  Future<List<ReadingProgress>> getCurrentlyReading() async {
    final all = await getAllProgress();
    return all
        .where((p) => p.progress > 0 && p.progress < 1.0)
        .toList()
      ..sort((a, b) => b.lastReadAt.compareTo(a.lastReadAt));
  }

  // ===== DELETE PROGRESS =====

  Future<void> deleteProgress(String bookId) async {
    final localKey = 'progress_$bookId';
    await _localBox.delete(localKey);

    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('reading_progress')
          .doc(bookId)
          .delete();
    } catch (_) {}
  }
}