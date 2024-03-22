// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// For clarity, this example uses the text representation of the sample remote
/// widget library, and parses it locally. To do this, [parseLibraryFile] is
/// used. In production, this is strongly discouraged since it is 10x slower
/// than using [decodeLibraryBlob] to parse the binary version of the format.
import 'package:rfw/formats.dart' show parseLibraryFile;

import 'package:rfw/rfw.dart';

void main() {
  runApp(const Example());
}

// The "#docregion" comment helps us keep this code in sync with the
// excerpt in the rfw package's README.md file.
//
// #docregion Example
class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void reassemble() {
    // This function causes the Runtime to be updated any time the app is
    // hot reloaded, so that changes to _createLocalWidgets can be seen
    // during development. This function has no effect in production.
    super.reassemble();
    _update();
  }

  static WidgetLibrary _createLocalWidgets() {
    return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
      'GreenBox': (BuildContext context, DataSource source) {
        return SizedBox(
          width: 300.0,
          height: 300.0,
          child: ColoredBox(
            color: const Color(0xFF002211),
            child: source.child(<Object>['child']),
          ),
        );
      },
      'Hello': (BuildContext context, DataSource source) {
        return Center(
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: Center(
              child: Text(
                'Hello, ${source.v<String>(<Object>["name"])}!',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
        );
      },
    });
  }

  static const LibraryName localName = LibraryName(<String>['local']);
  static const LibraryName remoteName = LibraryName(<String>['remote']);

  void _update() {
    _runtime.update(localName, _createLocalWidgets());
    // Normally we would obtain the remote widget library in binary form from a
    // server, and decode it with [decodeLibraryBlob] rather than parsing the
    // text version using [parseLibraryFile]. However, to make it easier to
    // play with this sample, this uses the slower text format.
    _runtime.update(remoteName, parseLibraryFile(widgets[currentWidget]));
  }

  final widgets = <String>[
    '''
      import local;
      widget root = GreenBox(
        child: Hello(name: "World"),
      );
    ''',
    '''
      import local;
      widget root = Hello(name: "World"
      );
    '''
  ];

  int currentWidget = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              currentWidget == 0 ? currentWidget = 1 : currentWidget = 0;
              _update();
            },
            child: RemoteWidget(
              runtime: _runtime,
              data: _data,
              widget: const FullyQualifiedWidgetName(remoteName, 'root'),
              onEvent: (String name, DynamicMap arguments) {
                debugPrint('user triggered event "$name" with data: $arguments');
              },
            ),
          ),
        ),
      ),
    );
  }
}
// #enddocregion Example
