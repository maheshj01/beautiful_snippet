import 'package:flutter/material.dart';
import 'package:beautiful_snippet/pages/beautiful_home.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart' show APP_TITLE;

void main() {
  runApp(BeautifulApp());
}

class BeautifulApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpecsModel>(create: (_) => SpecsModel()),
      ],
      child: Consumer<SpecsModel>(
        builder: (_, c, x) => MaterialApp(
          title: '$APP_TITLE',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BeautifulHome(),
        ),
      ),
    );
  }
}
