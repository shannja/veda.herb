import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vedaherb/features/session/domain/models.dart';
import 'package:vedaherb/features/session/persistence.dart';

/// Repository for session data persistence.
/// 
/// Handles serialization and deserialization of session data to/from
/// SharedPreferences, with proper error handling and validation.
class SessionRepository {
  /// Creates a new SessionRepository instance.
  /// 
  /// [prefs] The SharedPreferences instance to use for persistence.
  SessionRepository(this._prefs);
  
  final SharedPreferences _prefs;

  /// The key used to store sessions in SharedPreferences.
  static const String _sessionsKey = 'saved_sessions';

  /// Saves all sessions to persistent storage.
  /// 
  /// [sessions] A map of session IDs to session data.
  /// 
  /// Throws an exception if serialization or storage fails.
  Future<void> saveSessions(Map<String, SessionData> sessions) async {
    try {
      final sessionsMap = <String, String>{};

      for (final entry in sessions.entries) {
        // Validate session data before saving
        if (entry.value.sessionId.isEmpty || entry.value.title.isEmpty) {
          debugPrint('SessionRepository: Skipping invalid session ${entry.key}');
          continue;
        }
        sessionsMap[entry.key] = jsonEncode(entry.value.toJson());
      }

      await _prefs.setString(_sessionsKey, jsonEncode(sessionsMap));
      debugPrint('SessionRepository: Saved ${sessionsMap.length} sessions');
    } catch (e, stackTrace) {
      debugPrint('SessionRepository: Failed to save sessions: $e');
      debugPrint('SessionRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Loads all sessions from persistent storage.
  /// 
  /// Returns an empty map if no sessions are found or if deserialization fails.
  Map<String, SessionData> loadSessions() {
    try {
      final sessionsJson = _prefs.getString(_sessionsKey);
      if (sessionsJson == null) return {};

      final sessionsMap = jsonDecode(sessionsJson) as Map<String, dynamic>;
      final result = <String, SessionData>{};

      for (final entry in sessionsMap.entries) {
        try {
          result[entry.key] = SessionDataJson.fromJson(jsonDecode(entry.value));
        } catch (e) {
          debugPrint('SessionRepository: Failed to deserialize session ${entry.key}: $e');
          // Skip corrupted sessions
        }
      }

      debugPrint('SessionRepository: Loaded ${result.length} sessions');
      return result;
    } catch (e) {
      debugPrint('SessionRepository: Failed to load sessions: $e');
      return {};
    }
  }

  /// Clears all stored sessions.
  /// 
  /// This is primarily used for debugging or when the user wants to reset data.
  Future<void> clearSessions() async {
    try {
      await _prefs.remove(_sessionsKey);
      debugPrint('SessionRepository: Cleared all sessions');
    } catch (e) {
      debugPrint('SessionRepository: Failed to clear sessions: $e');
      rethrow;
    }
  }
}

