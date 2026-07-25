// lib/data/repositories/bookmark_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';    // FirebaseFirestore
                                                          // CollectionReference
                                                          // DocumentSnapshot
import 'package:firebase_auth/firebase_auth.dart';        // FirebaseAuth
                                                          // currentUser
                                                          // uid
import 'package:hive/hive.dart';                          // Box<dynamic>
                                                          // .get()
                                                          // .put()

// Data - Models
import '../models/bookmark.dart';                         // Bookmark
                                                          // .fromJson()
                                                          // .toJson()

// ─────────────────────────────────────────────────────────────────────────────

class BookmarkRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Box<dynamic> _localBox;

  BookmarkRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required Box<dynamic> localBox,
  })  : _firestore = firestore,
        _auth = auth,
        _localBox = localBox;

  String get _userId => _auth.currentUser?.uid ?? 'anonymous';

  CollectionReference get _bookmarksRef => _firestore
      .collection('users')
      .doc(_userId)
      .collection('bookmarks');

  // ===== GET BOOKMARKS =====

  Future<List<Bookmark>> getBookmarks(String bookId) async {
    try {
      final snapshot = await _bookmarksRef
          .where('bookId', isEqualTo: bookId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Bookmark.fromJson(data);
      }).toList();
    } catch (_) {
      // Fallback to local
      final localKey = 'bookmarks_$bookId';
      final localData = _localBox.get(localKey);
      if (localData != null) {
        final list = List<Map<String, dynamic>>.from(
          (localData as List).map((e) => Map<String, dynamic>.from(e)),
        );
        return list.map((e) => Bookmark.fromJson(e)).toList();
      }
      return [];
    }
  }

  // ===== ADD BOOKMARK =====

  Future<void> addBookmark(Bookmark bookmark) async {
    // Save to remote
    try {
      await _bookmarksRef.add(bookmark.toJson());
    } catch (_) {}

    // Save locally
    await _saveBookmarkLocally(bookmark);
  }

  // ===== REMOVE BOOKMARK =====

  Future<void> removeBookmark(String bookId, int page) async {
    // Remove from remote
    try {
      final snapshot = await _bookmarksRef
          .where('bookId', isEqualTo: bookId)
          .where('page', isEqualTo: page)
          .get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (_) {}

    // Remove locally
    await _removeBookmarkLocally(bookId, page);
  }

  // ===== GET ALL BOOKMARKS =====

  Future<List<Bookmark>> getAllBookmarks() async {
    try {
      final snapshot = await _bookmarksRef
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Bookmark.fromJson(data);
      }).toList();
    } catch (_) {
      return [];
    }
  }

  // ===== UPDATE BOOKMARK NOTE =====

  Future<void> updateBookmarkNote(
    String bookmarkId,
    String note,
  ) async {
    try {
      await _bookmarksRef.doc(bookmarkId).update({'note': note});
    } catch (_) {}
  }

  // ===== LOCAL HELPERS =====

  Future<void> _saveBookmarkLocally(Bookmark bookmark) async {
    final localKey = 'bookmarks_${bookmark.bookId}';
    final existing = _localBox.get(localKey);
    final list = existing != null
        ? List<Map<String, dynamic>>.from(
            (existing as List).map((e) => Map<String, dynamic>.from(e)),
          )
        : <Map<String, dynamic>>[];

    list.add(bookmark.toJson());
    await _localBox.put(localKey, list);
  }

  Future<void> _removeBookmarkLocally(String bookId, int page) async {
    final localKey = 'bookmarks_$bookId';
    final existing = _localBox.get(localKey);
    if (existing == null) return;

    final list = List<Map<String, dynamic>>.from(
      (existing as List).map((e) => Map<String, dynamic>.from(e)),
    );
    list.removeWhere((b) => b['page'] == page);
    await _localBox.put(localKey, list);
  }
}