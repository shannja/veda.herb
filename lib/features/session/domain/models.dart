import 'package:flutter/foundation.dart';

/// Entry point for a session, determining how the session was started.
/// 
/// - [camera]: Session started by capturing/scanning an herb image
/// - [chat]: Session started by typing symptoms or questions
enum SessionEntryPoint { camera, chat }

/// Represents the current state of a session.
/// 
/// The state machine flows:
/// - [cameraFullscreen] -> [transitioning] -> [chatting]
/// - [chatting] -> [suggesting] -> [monitoring] -> [escalating] -> [resolved]
enum SessionState {
  /// Camera view is shown fullscreen
  cameraFullscreen,
  
  /// Transitioning between states
  transitioning,
  
  /// Active chat conversation
  chatting,
  
  /// AI is suggesting remedies
  suggesting,
  
  /// Monitoring user progress
  monitoring,
  
  /// Escalating to medical professional
  escalating,
  
  /// Session completed
  resolved,
}

/// Type of message in a chat conversation.
enum MessageType { 
  /// Regular text message
  text, 
  /// Plant identification result
  plantResult, 
  /// Suggestion from AI
  suggestion, 
  /// Monitoring update
  monitoring 
}

/// Represents a single message in a session chat.
/// 
/// Messages can be from the user or the AI assistant, and may
/// optionally include an image path for plant identification.
@immutable
class SessionChatMessage {
  final String id;
  final String text;
  /// Absolute path to a locally persisted image (app documents), if any.
  final String? localImagePath;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;

  /// Creates a new session chat message.
  /// 
  /// [id] Unique identifier for this message.
  /// [text] The message text content.
  /// [localImagePath] Optional path to a locally stored image.
  /// [isUser] Whether this message was sent by the user.
  /// [timestamp] When this message was created.
  /// [type] The type of message.
  const SessionChatMessage({
    required this.id,
    required this.isUser, required this.timestamp, this.text = '',
    this.localImagePath,
    this.type = MessageType.text,
  });

  SessionChatMessage copyWith({
    String? id,
    String? text,
    String? localImagePath,
    bool? isUser,
    DateTime? timestamp,
    MessageType? type,
  }) {
    return SessionChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      localImagePath: localImagePath ?? this.localImagePath,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }
}

/// Complete data for a session, including all messages and state.
/// 
/// This class represents the full state of a consultation session,
/// including the conversation history, identified plants, and current
/// session state.
@immutable
class SessionData {
  /// Unique identifier for this session.
  final String sessionId;
  
  /// User-friendly title for the session.
  final String title;
  
  /// How this session was started (camera scan or chat).
  final SessionEntryPoint entryPoint;
  
  /// All messages in this session's conversation.
  final List<SessionChatMessage> messages;
  
  /// Name of the plant identified in this session, if any.
  final String? identifiedPlant;
  
  /// Current state of the session.
  final SessionState currentState;
  
  /// When this session was created.
  final DateTime createdAt;
  
  /// When this session was last updated.
  final DateTime lastUpdated;

  /// Creates a new session data instance.
  const SessionData({
    required this.sessionId,
    required this.title,
    required this.entryPoint,
    required this.messages,
    required this.identifiedPlant,
    required this.currentState,
    required this.createdAt,
    required this.lastUpdated,
  });

  SessionData copyWith({
    String? sessionId,
    String? title,
    SessionEntryPoint? entryPoint,
    List<SessionChatMessage>? messages,
    String? identifiedPlant,
    SessionState? currentState,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return SessionData(
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      entryPoint: entryPoint ?? this.entryPoint,
      messages: messages ?? this.messages,
      identifiedPlant: identifiedPlant ?? this.identifiedPlant,
      currentState: currentState ?? this.currentState,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

