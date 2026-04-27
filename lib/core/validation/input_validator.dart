import 'package:flutter/foundation.dart';

/// Input validation utility for the VedaHerb application.
/// 
/// Provides validation and sanitization methods for user inputs
/// to prevent injection attacks and data corruption.
class InputValidator {
  InputValidator._();

  /// Maximum length for text inputs to prevent storage bloat
  static const int maxTextLength = 5000;

  /// Maximum length for titles
  static const int maxTitleLength = 100;

  /// Validates a session ID format.
  /// 
  /// Session IDs should be alphanumeric with optional hyphens and underscores.
  /// Returns true if the ID is valid.
  static bool isValidSessionId(String? id) {
    if (id == null || id.isEmpty) return false;
    // Allow alphanumeric, hyphens, underscores; max 50 chars
    return RegExp(r'^[a-zA-Z0-9_-]{1,50}$').hasMatch(id);
  }

  /// Sanitizes text input by removing potentially dangerous characters.
  /// 
  /// Removes angle brackets and limits length to prevent injection attacks.
  static String sanitizeText(String input) {
    if (input.isEmpty) return input;
    
    // Remove angle brackets to prevent HTML/XML injection
    String sanitized = input.replaceAll(RegExp(r'[<>]'), '');
    
    // Remove null bytes
    sanitized = sanitized.replaceAll(String.fromCharCode(0), '');
    
    // Trim and limit length
    if (sanitized.length > maxTextLength) {
      sanitized = sanitized.substring(0, maxTextLength);
    }
    
    return sanitized.trim();
  }

  /// Sanitizes a title string.
  /// 
  /// More restrictive than general text - removes special characters.
  static String sanitizeTitle(String input) {
    if (input.isEmpty) return input;
    
    // Remove potentially dangerous characters: < > " ' &
    String sanitized = input.replaceAll('<', '');
    sanitized = sanitized.replaceAll('>', '');
    sanitized = sanitized.replaceAll('"', '');
    sanitized = sanitized.replaceAll("'", '');
    sanitized = sanitized.replaceAll('&', '');
    
    // Limit length
    if (sanitized.length > maxTitleLength) {
      sanitized = sanitized.substring(0, maxTitleLength);
    }
    
    return sanitized.trim();
  }

  /// Validates and sanitizes a file path.
  /// 
  /// Ensures the path doesn't contain directory traversal attempts.
  static bool isValidPath(String path) {
    if (path.isEmpty) return false;
    
    // Check for directory traversal attempts
    if (path.contains('..') || path.contains('../') || path.contains('..\\')) {
      debugPrint('InputValidator: Potential directory traversal detected in path');
      return false;
    }
    
    // Check for null bytes
    if (path.contains(String.fromCharCode(0))) {
      debugPrint('InputValidator: Null byte detected in path');
      return false;
    }
    
    return true;
  }

  /// Validates that a string is not empty after trimming.
  static bool isNotBlank(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Truncates a string to the specified length with an optional ellipsis.
  static String truncate(String value, int maxLength, {bool addEllipsis = true}) {
    if (value.length <= maxLength) return value;
    
    final ellipsis = addEllipsis ? '...' : '';
    final truncateAt = maxLength - ellipsis.length;
    
    if (truncateAt <= 0) return ellipsis;
    
    return '${value.substring(0, truncateAt)}$ellipsis';
  }
}