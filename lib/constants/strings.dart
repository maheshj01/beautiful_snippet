/// app string constants  from the UI go here in this page
/// e.g
const String APP_TITLE = 'Beautiful Snippet';
List<String> languages = ['Dart'];
List<String> themes = ['Gradient-Dark', 'An-Old-Hope', 'Xcode', 'Monokai'];

const String sourceTemplate = """
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
      home: MyApp(),
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
