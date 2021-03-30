/// app string constants  from the UI go here in this page
/// e.g
const String APP_TITLE = 'Beautiful Snippet';
List<String> languages = ['Dart'];
List<String> themes = ['Gradient-Dark', 'An-Old-Hope', 'Xcode', 'Monokai'];

const String sourceTemplate =
    """// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyBeautifulApp());

class MyBeautifulApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Snippet Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
""";

List<String> keywords = [
  'abstract',
  'class',
  'enum',
  'extends',
  'extension',
  'external',
  'factory',
  'implements',
  'get',
  'mixin',
  'native',
  'operator',
  'set',
  'typedef',
  'with',
  'covariant'
];
