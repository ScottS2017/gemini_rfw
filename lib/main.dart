import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rfw_testing/data/localChatParameters.dart';
import 'package:rfw_testing/features/home_screen.dart';
import 'package:rfw_testing/models/local_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static LocalChat providedLocalChatOf(BuildContext context) {
    final MyAppState state = context.findAncestorStateOfType<MyAppState>()!;
    return state._providedLocalChat;
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  late LocalChat _providedLocalChat;

  @override
  void initState() {
    super.initState();
    _providedLocalChat = LocalChat(
      name: LocalChatParameters.modelName,
      personality: LocalChatParameters.modelPersonality,
      situation: LocalChatParameters.modelSituation,
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade800),
        useMaterial3: true,
      ),
      // home: const Example(),

      home: const HomeScreen(title: 'AI Demo'),
    );
  }
}