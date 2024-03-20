import 'package:flutter/foundation.dart' show debugPrint;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rfw_testing/backend/api_key.dart';

Future<void> testGeminiResponse() async {
  const prompt = "Generate JSON for use with Remote Flutter Widgets, describing a Flutter RFW Button widget with a blue to red gradient that runs top to bottom, a black border with rounded corners, and the text 'Click Me' in font size 14, yellow, and italic. Ensure valid JSON format.";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final singleContentItem = Content.text(prompt);
  GenerateContentResponse
      response; // Send the current list of [Content] (with the last user message) to the AI in the cloud.

  response = await model.generateContent([singleContentItem]);
  final resultantTextPart = response.candidates.last.content.parts[0] as TextPart;
  // Now that it's been cast, the text can be extracted from it.
  final responseText = resultantTextPart.text;

  debugPrint(responseText); // Print the response from Gemini
}

