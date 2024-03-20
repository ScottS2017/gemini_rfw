import 'package:rfw_testing/main.dart';
import 'package:rfw_testing/models/local_chat.dart';
import 'package:rfw_testing/utils/spacing_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _inputController = TextEditingController();
  final _inputFieldFocusNode = FocusNode();

  // Helps prevent an error, used in [initState()]
  bool _isInitialized = false;

  // The future used the the UI's [FutureBuilder].
  Future<void>? _futureResponse;

  // App bar color. This is declared as a Color instead of var because of an issue with type inference not working properly in a cascading if statement.
  Color _color = Colors.red;

  /// The width of the animated container.
  double _containerWidth = 100.0;

  /// The corner radius of the animated container.
  double _cornerRadius = 0.0;

  late LocalChat gemini;

  void _handleSubmit() {
    debugPrint('Handling Submission');
    // If we don't have a response from the previous message yet, don't do anything because there will be an error if Gemini gets a List<Content> that contains two messages in a row from either the user or itself.
    if (gemini.awaitingResponse) return;
    setState(() {
      // Process the prompt, then change the value of [_futureResponse], which triggers the [FutureBuilder].
      _futureResponse = gemini.processSend(prompt: _inputController.text);
      _inputController.clear();
      // Set focus back to input field.
      _inputFieldFocusNode.requestFocus();
    });
  }

  @override
  void initState() {
    debugPrint('initState');
    super.initState();
    setState(() {
      gemini = MyApp.providedLocalChatOf(context);
      gemini.initChat();
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    debugPrint('Dispose Called');
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Home Screen Rebuilt');
    return Scaffold(
      appBar: AppBar(
        // Using [_color] here allows the AI to change [AbbBar.backgroundColor] programmatically.
        backgroundColor: _color,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Section: Input field.
              TextField(
                controller: _inputController,
                focusNode: _inputFieldFocusNode,
                onSubmitted: (_) => _handleSubmit(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Me:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              verticalMargin16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      gemini.chatHistoryContent
                          .removeRange(1, gemini.chatHistoryContent.length - 1);
                      gemini.messageHistory.removeRange(1, gemini.messageHistory.length - 1);
                    },
                    child: const SizedBox(
                      height: 50.0,
                      width: 150.0,
                      child: Center(
                        child: Text('Reset the Context'),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: 100.0,
                    width: _containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
                    ),
                  ),
                  const SizedBox(width: 150.0),
                ],
              ),
              verticalMargin16,
              // Section: Most recent message from the model.
              Expanded(
                flex: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<String>(
                          valueListenable: gemini.latestResponseFromModel,
                          builder: (BuildContext context, String value, _) {
                            return SelectableText(
                              gemini.latestResponseFromModel.value ?? '',
                              maxLines: 1000,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              verticalMargin16,
              // Section: The chat history so far, excluding commands.
              Expanded(
                child: SizedBox.expand(
                  child: ColoredBox(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<void>(
                        future: _futureResponse,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (_futureResponse == null) {
                            return const Text('Enter a question above.');
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (true) {
                            final numberOfChildren = gemini.messageHistory.length;
                            return Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: numberOfChildren,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (index > 2 && index < gemini.messageHistory.length - 1)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: SelectableText(
                                            '${gemini.messageHistory[index].who}: ${gemini.messageHistory[index].message}',
                                            style: const TextStyle(fontSize: 12.0),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      if (index > 1 && index < gemini.messageHistory.length)
                                        verticalMargin8,
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
