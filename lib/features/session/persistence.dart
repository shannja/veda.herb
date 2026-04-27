import 'package:vedaherb/features/session/domain/models.dart';

// ============================================================================
// JSON Serialization Extensions
// ============================================================================
// These extensions provide toJson/fromJson methods for session models.
// They are used by SessionRepository for persistence.
// ============================================================================

/// Extension on [SessionData] for JSON serialization.
extension SessionDataJson on SessionData {
  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'title': title,
      'entryPoint': entryPoint.index,
      'messages': messages.map((m) => m.toJson()).toList(),
      'identifiedPlant': identifiedPlant,
      'currentState': currentState.index,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  
  static SessionData fromJson(Map<String, dynamic> json) {
    return SessionData(
      sessionId: json['sessionId'],
      title: json['title'],
      entryPoint: SessionEntryPoint.values[json['entryPoint']],
      messages: (json['messages'] as List)
          .map((m) => ChatMessageJson.fromJson(m))
          .toList(),
      identifiedPlant: json['identifiedPlant'],
      currentState: SessionState.values[json['currentState']],
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}

/// Extension on [SessionChatMessage] for JSON serialization.
extension ChatMessageJson on SessionChatMessage {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      if (localImagePath != null) 'localImagePath': localImagePath,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'type': type.index,
    };
  }
  
  static SessionChatMessage fromJson(Map<String, dynamic> json) {
    return SessionChatMessage(
      id: json['id'],
      text: json['text'] as String? ?? '',
      localImagePath: json['localImagePath'] as String?,
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
      type: MessageType.values[json['type']],
    );
  }
}