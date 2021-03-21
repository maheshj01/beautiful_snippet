import 'package:flutter/material.dart';
import 'package:beautiful_snippet/pages/beautiful_home.dart';
import 'constants/constants.dart' show APP_TITLE;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$APP_TITLE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BeautifulHome(),
    );
  }
}
