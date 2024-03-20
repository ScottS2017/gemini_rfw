import 'package:google_generative_ai/google_generative_ai.dart';

/// A type of chat message, text only or a command that results in an action.5
enum MessageType {text, command}

class ChatMessage{
  ChatMessage({
    required this.role,
    required this.messageBody,
    required this.type,
  });
  String role;
  MessageType type;
  List<Content> messageBody;
}
