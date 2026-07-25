// lib/data/repositories/search_repository.dart

import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences
                                                             // .getStringList()
                                                             // .setStringList()
                                                             // .remove()

import 'package:cloud_firestore/cloud_firestore.dart';       // FirebaseFirestore
                                                             // .collection()
                                                             // .doc()
                                                             // .get()
                                                             // .exists
                                                             // .data()

// ─────────────────────────────────────────────────────────────────────────────

class SearchRepository {
  static const _recentKey = 'recent_searches';
  static const _maxRecent = 10;

  final SharedPreferences _prefs;
  final FirebaseFirestore _firestore;

  SearchRepository({
    required SharedPreferences prefs,
    required FirebaseFirestore firestore,
  })  : _prefs = prefs,
        _firestore = firestore;

  // ─────────────────────────────────────────
  // RECENT SEARCHES
  // ─────────────────────────────────────────

  Future<List<String>> getRecentSearches() async {
    return _prefs.getStringList(_recentKey) ?? [];
  }

  Future<void> saveRecentSearch(
    String query,
  ) async {
    final recent = await getRecentSearches();

    recent.remove(query);   // Remove if exists
    recent.insert(0, query); // Add to front

    if (recent.length > _maxRecent) {
      recent.removeLast();
    }

    await _prefs.setStringList(
      _recentKey,
      recent,
    );
  }

  Future<void> clearRecentSearches() async {
    await _prefs.remove(_recentKey);
  }

  // ─────────────────────────────────────────
  // TRENDING SEARCHES
  // ─────────────────────────────────────────

  Future<List<String>> getTrendingSearches() async {
    try {
      final doc = await _firestore
          .collection('app_config')
          .doc('trending')
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        return List<String>.from(
          data['searches'] ?? [],
        );
      }
    } catch (_) {}

    // Fallback
    return [
      'Atomic Habits',
      'The Midnight Library',
      'Project Hail Mary',
      'Dune',
      'Think Again',
      'The Psychology of Money',
      'Sapiens',
      'The Silent Patient',
    ];
  }
}