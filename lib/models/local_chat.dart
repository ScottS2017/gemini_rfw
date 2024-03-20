import 'dart:ffi';

import 'package:flutter/material.dart' show debugPrint, ValueNotifier;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rfw_testing/backend/api_key.dart';

/// An individual chat, with a personality, situation, and chat history.
class LocalChat {
  LocalChat({
    required this.name,
    required this.personality,
    required this.situation,
  });

  /// The name associated with this chat.
  String name;

  /// The personality characteristics associated with this chat.
  String personality;

  /// The situation given to this chat. EG: Personal assistant, coding partner, etc.
  String situation;

  /// A list that holds the history of text only messages.
  final messageHistory = <CustomChatMessage>[];

  /// The chat history of this chat.
  final chatHistoryContent = <Content>[];

  /// Used to prevent a second message from being sent by the user before a response to the previous message has been received.
  bool awaitingResponse = false;

  // The most recent text response from the model. Used to display the most recent response in the large font, [SelectableText] in the middle of the screen.
  final ValueNotifier<String> _latestResponseFromModel = ValueNotifier<String>('');
  ValueNotifier<String> get latestResponseFromModel => _latestResponseFromModel;

  // For text-only input, use the gemini-pro model
  final _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  String prompt() =>
      'This is role play. For this interaction you are portraying a person named $name. You are also given a personality, situation, and a message from the user. The personality and situation may change during any given conversation, every new personality or situation will be labeled in this context, use the most recent one. Answer to the name $name, respond to the user\'s input appropriately considering the personality and situation given, and be sure to use only words in your responses because there is an error if you try to respond with anything else. This means you especially need to show code in plain text instead of in code blocks. The current personality for $name is: "$personality". The current situation for $name is: "$situation". Additionally, you have the ability to trigger methods in the client-side app. This is done by prefixing what you say with "CMDACT". It stands for Command Action, and it will cause the client side app to process your response as an action instead of printing the text. If you say "CMDACT UI Blue", it will turn the app bar color blue. Here is a list of valid commands: You can make the UI red, green, blue, purple, or orange with "CMDACT UI <color>", and the first letter in the color must be capitalized. You can also trigger an animation with "CMDACT animate". If I ask you to round the box or its corners, return "CMDACT box 50", if I say square it then return "CMDACT box 0", and if I ask you to change the widget your responses could be "CMDACT firstWidget", "CMDACT secondWidget", or "CMDACT thirdWidget". When you send a command, send only the command, by itself without any other text, or line breaks.';

  /// The chat needs to be initialized with one message from each side to get it kicked off. You provide these, but they don't get displayed.
  void initChat() {
    debugPrint('Initializing Chat');
    updateChatHistory(who: 'user', latestMessage: prompt());
    updateChatHistory(who: 'model', latestMessage: "Sounds good. I'll do my best.");
  }

  // Processes the outgoing and incoming messages.
  Future<void> processSend({required String prompt}) async {
    debugPrint('Processing Send');
    // A message is in progress, prevent another from being sent.
    awaitingResponse = true;

    // Add the current chat message from the user to the list of the google_generative_ai [Content] objects.
    updateChatHistory(who: 'user', latestMessage: prompt);
    // Create a list of [Content] with current active chat history and all messages before it.
    List<Content> content = chatHistoryContent;
    // Declare a response object.
    GenerateContentResponse
        response; // Send the current list of [Content] (with the last user message) to the AI in the cloud.
    try {
      response = await _model.generateContent(content);
      _processReceive(response: response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _processReceive({required GenerateContentResponse response}) {
    debugPrint('Processing Receive');
    // Create a variable for the model's [TextPart] response. This is _not_ the text. It is an object that extends [Part]. The [Content] contains [Part] objects and it does not differentiate between [TextPart] and [DataPart], so we need to cast this as a [TextPart] before we can use it.
    final resultantTextPart = response.candidates.last.content.parts[0] as TextPart;
    // Now that it's been cast, the text can be extracted from it.
    final responseText = resultantTextPart.text;
    // Processing has finished, allow a new message to be sent.
    awaitingResponse = false;
    // Add the response message from the user to the list of the google_generative_ai [Content] objects.
    updateChatHistory(who: 'model', latestMessage: responseText);
    if (responseText.length > 5) {
      final check = responseText.substring(0, 6);
      if (check == 'CMDACT' || check == '```jso') {
        // The response was an action.
        processAction(response.text!);
      } else {
        latestResponseFromModel.value = responseText;
      }
    } else {
      latestResponseFromModel.value = responseText;
    }
  }

  /// Processes a command action that is not a text message.
  String? processAction(String response) {
    debugPrint('Processing Action. It was $response');
    String result = '';
    if(response.startsWith('{')){
      debugPrint(response);
      // TODO Implement me
    } else {
      switch (response) {
        case 'CMDACT animate 300':
          result = 'containerWidth 300.0';
        case 'CMDACT animate 100':
          result = 'containerWidth 100.0';
        case 'CMDACT box 50':
          result = '_cornerRadius = 50.0';
        case 'CMDACT box 0':
          result = '_cornerRadius = 0';
        case 'CMDACT firstWidget':
          result = 'firstWidget';
        case 'CMDACT secondWidget':
          result = 'secondWidget';
        case 'CMDACT thirdWidget':
          result = 'thirdWidget';
        default:
          result = response.substring(7, response.length);
      }
      if(result.isNotEmpty) {
        debugPrint(result);
        return result;
      }
    }
  }

  /// Update the chat history.
  void updateChatHistory({required String who, required String latestMessage}) {
    debugPrint('Updating Chat History');
    if (who == 'user') {
      chatHistoryContent.add(Content.text(latestMessage));
      messageHistory.add(CustomChatMessage(who: 'user', message: latestMessage));
    } else {
      chatHistoryContent.add(
        Content.model([TextPart(latestMessage)]),
      );
      if (latestMessage.length > 5 && latestMessage.substring(0, 6) != 'CMDACT') {
        messageHistory.add(CustomChatMessage(who: 'model', message: latestMessage));
      }
    }
  }
}

/// Represents a single message sent by either the user or the AI.
class CustomChatMessage {
  CustomChatMessage({
    required this.who,
    required this.message,
  });

  /// Whe the text message was from.
  String who;

  /// What the text message was.
  String message;
}
