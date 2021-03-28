import 'package:flutter/material.dart';
import 'package:beautiful_snippet/exports.dart';
import 'package:beautiful_snippet/pages/snippet_frame.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:provider/provider.dart';

class BeautifulHome extends StatefulWidget {
  @override
  _BeautifulHomeState createState() => _BeautifulHomeState();
}

class _BeautifulHomeState extends State<BeautifulHome> {
  SnippetController snippetController = SnippetController();
  @override
  Widget build(BuildContext context) {
    final specs = Provider.of<SpecsModel>(context, listen: false);
    return Scaffold(
      backgroundColor: specs.backgroundColor,
      appBar: AppBar(
        title: Text('$APP_TITLE',
            style: TextStyle(
                color: specs.backgroundColor == white ? white : black,
                fontSize: font_h3)),
        backgroundColor: specs.backgroundColor == white ? black : white,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: specs.backgroundColor,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                snippetController.generateImage();
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SnippetFrame(
        controller: snippetController,
      ),
    );
  }
}
